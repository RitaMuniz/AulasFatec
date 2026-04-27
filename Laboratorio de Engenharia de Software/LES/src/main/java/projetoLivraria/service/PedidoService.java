package projetoLivraria.service;

import projetoLivraria.dao.*;
import projetoLivraria.model.*;
import projetoLivraria.uteis.ConexaoSQL;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.util.List;

public class PedidoService {

    // Valor mínimo cobrado por cartão quando há cartões envolvidos
    private static final BigDecimal MINIMO_POR_CARTAO = new BigDecimal("10.00");

    private final PedidoDAO pedidoDAO = new PedidoDAO();
    private final ItemPedidoDAO itemPedidoDAO = new ItemPedidoDAO();
    private final PagamentoDAO pagamentoDAO = new PagamentoDAO();
    private final CupomDAO cupomDAO = new CupomDAO();
    private final EstoqueDAO estoqueDAO = new EstoqueDAO();

    // CÁLCULO DE FRETE
    // Baseado no peso total dos livros do carrinho.
    // Regra simplificada por faixa de CEP (primeiros 2 dígitos = região).

    /**
     * Calcula o frete com base no peso total dos itens e na região do CEP de entrega.
     *
     * Tabela de regiões (2 primeiros dígitos do CEP):
     *   01–19  → SP capital          base R$ 15,00
     *   20–28  → RJ/ES               base R$ 18,00
     *   30–38  → MG                  base R$ 18,00
     *   40–48  → BA/SE               base R$ 22,00
     *   49–63  → NE                  base R$ 27,00
     *   64–65  → PI/MA               base R$ 30,00
     *   66–68  → PA/AP/AM/RR         base R$ 35,00
     *   69     → AM/RR               base R$ 38,00
     *   70–76  → DF/GO/TO            base R$ 20,00
     *   77–79  → MT/MS/RO            base R$ 25,00
     *   80–87  → PR                  base R$ 17,00
     *   88–89  → SC                  base R$ 17,00
     *   90–99  → RS                  base R$ 19,00
     *   outros → R$ 25,00 (padrão)
     *
     * Acréscimo por peso: R$ 2,00 por kg acima de 500g.
     *
     * @param cep           CEP do endereço de entrega (somente dígitos ou com hífen)
     * @param pesoTotalKg   peso total dos livros em kg
     */
    public BigDecimal calcularFrete(String cep, double pesoTotalKg) {
        String digits = cep == null ? "" : cep.replaceAll("[^0-9]", "");
        BigDecimal base;

        if (digits.length() >= 2) {
            int prefixo = Integer.parseInt(digits.substring(0, 2));
            if (prefixo <= 19) base = new BigDecimal("15.00");
            else if (prefixo <= 28) base = new BigDecimal("18.00");
            else if (prefixo <= 38) base = new BigDecimal("18.00");
            else if (prefixo <= 48) base = new BigDecimal("22.00");
            else if (prefixo <= 65) base = new BigDecimal("27.00");
            else if (prefixo <= 68) base = new BigDecimal("35.00");
            else if (prefixo <= 69) base = new BigDecimal("38.00");
            else if (prefixo <= 76) base = new BigDecimal("20.00");
            else if (prefixo <= 79) base = new BigDecimal("25.00");
            else if (prefixo <= 87) base = new BigDecimal("17.00");
            else if (prefixo <= 89) base = new BigDecimal("17.00");
            else if (prefixo <= 99) base = new BigDecimal("19.00");
            else base = new BigDecimal("25.00");
        } else {
            base = new BigDecimal("25.00");
        }

        // Acréscimo: R$ 2,00 por kg acima de 500g
        double excedente = Math.max(0, pesoTotalKg - 0.5);
        BigDecimal adicional = BigDecimal.valueOf(Math.ceil(excedente) * 2.0);

        return base.add(adicional).setScale(2, RoundingMode.HALF_UP);
    }

    /**
     * Finaliza a compra validando todas as regras de negócio.
     *
     * Regras de pagamento:
     * 1. Se há dois cartões, cada um deve ter valor >= R$ 10,00 —
     *    EXCETO quando há cupons que cobrem parte do total, reduzindo o
     *    valor restante a menos de R$ 10,00 (nesse caso o valor menor é permitido).
     * 2. Os cupons nunca podem superar o total bruto; se sobrarem créditos,
     *    um cupom de troca é gerado com a diferença.
     * 3. soma(cartões) + soma(cupons_usados) == total bruto.
     */
    public int finalizarCompra(
            int clienteId,
            int enderecoId,
            Carrinho carrinho,
            BigDecimal frete,
            Integer cartao1Id, BigDecimal valorCartao1,
            Integer cartao2Id, BigDecimal valorCartao2,
            List<Cupom> cupons   // lista de cupons selecionados (pode ser vazia)
    ) throws Exception {

        List<ItemCarrinho> itens = carrinho.getItens();
        if (itens == null || itens.isEmpty()) {
            throw new Exception("Carrinho vazio.");
        }

        //1. Totais base
        BigDecimal subtotal = itens.stream()
                .map(ItemCarrinho::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal totalBruto = subtotal.add(frete).setScale(2, RoundingMode.HALF_UP);

        //2. Valor total dos cupons selecionados
        BigDecimal totalCupons = BigDecimal.ZERO;
        if (cupons != null) {
            for (Cupom c : cupons) {
                if (c != null && c.getValor() != null) {
                    totalCupons = totalCupons.add(c.getValor());
                }
            }
        }

        // Cupons não podem ultrapassar o total bruto
        // (a UI já deve impedir, mas validamos aqui também)
        if (totalCupons.compareTo(totalBruto) > 0) {
            throw new Exception(
                    "Valor dos cupons (R$ " + totalCupons.toPlainString() +
                            ") supera o total do pedido (R$ " + totalBruto.toPlainString() +
                            "). Use cupons de menor valor ou remova cupons.");
        }

        BigDecimal desconto = totalCupons.setScale(2, RoundingMode.HALF_UP);
        BigDecimal totalLiquido = totalBruto.subtract(desconto).setScale(2, RoundingMode.HALF_UP);

        //3. Validações dos cartões
        BigDecimal v1 = valorCartao1 != null ? valorCartao1.setScale(2, RoundingMode.HALF_UP) : BigDecimal.ZERO;
        BigDecimal v2 = (cartao2Id != null && valorCartao2 != null)
                ? valorCartao2.setScale(2, RoundingMode.HALF_UP)
                : BigDecimal.ZERO;
        BigDecimal somaCartoes = v1.add(v2);

        // Soma dos cartões deve cobrir exatamente o totalLiquido
        if (somaCartoes.compareTo(totalLiquido) != 0) {
            throw new Exception(
                    "Pagamento inválido: soma dos cartões (R$ " + somaCartoes.toPlainString() +
                            ") difere do valor a pagar (R$ " + totalLiquido.toPlainString() + ").");
        }

        // Regra do mínimo por cartão
        // Quando há dois cartões E o total líquido >= R$ 20,00,
        // cada cartão deve ter pelo menos R$ 10,00.
        // Exceção: se o total líquido < R$ 10,00 (foi muito coberto por cupons),
        // o único cartão pode ter valor menor que R$ 10,00 (regra do enunciado).
        if (cartao2Id != null) {
            // há dois cartões: ambos precisam de R$ 10 mínimo,
            // A MENOS que o totalLiquido inteiro seja < 10 (caso em que só 1 cartão deveria ser usado)
            if (totalLiquido.compareTo(MINIMO_POR_CARTAO) >= 0) {
                if (v1.compareTo(MINIMO_POR_CARTAO) < 0) {
                    throw new Exception(
                            "O valor mínimo por cartão é R$ 10,00. " +
                                    "O Cartão 1 está com R$ " + v1.toPlainString() + ".");
                }
                if (v2.compareTo(MINIMO_POR_CARTAO) < 0) {
                    throw new Exception(
                            "O valor mínimo por cartão é R$ 10,00. " +
                                    "O Cartão 2 está com R$ " + v2.toPlainString() + ".");
                }
            }
        }
        // Quando há apenas 1 cartão e cupons cobriram parte:
        // o cartão pode ter valor menor que R$ 10,00 (conforme enunciado).
        // Nenhuma validação adicional necessária.

        //4. Persistência em transação
        Connection con = ConexaoSQL.getInstance().getConnection();
        con.setAutoCommit(false);

        try {
            // 4a. Validar estoque
            for (ItemCarrinho ic : itens) {
                int disponivel = estoqueDAO.buscarQuantidade(ic.getLivroId(), con);
                if (ic.getQuantidade() > disponivel) {
                    throw new Exception("Estoque insuficiente para \"" +
                            ic.getLivro().getTitulo() + "\". Disponível: " + disponivel +
                            ", solicitado: " + ic.getQuantidade());
                }
            }

            // 4b. Criar pedido
            Pedido pedido = new Pedido();
            pedido.setClienteId(clienteId);
            pedido.setEnderecoEntregaId(enderecoId);
            pedido.setSubtotal(subtotal);
            pedido.setFrete(frete);
            pedido.setDesconto(desconto);
            pedido.setTotal(totalLiquido);
            pedido.setStatus("EM_PROCESSAMENTO");

            int pedidoId = pedidoDAO.inserir(pedido, con);

            // 4c. Itens + decremento de estoque
            for (ItemCarrinho ic : itens) {
                ItemPedido item = new ItemPedido();
                item.setPedidoId(pedidoId);
                item.setLivroId(ic.getLivroId());
                item.setQuantidade(ic.getQuantidade());
                item.setPrecoUnitario(ic.getPrecoUnitario());
                itemPedidoDAO.inserir(item, con);
                estoqueDAO.decrementar(ic.getLivroId(), ic.getQuantidade(), con);
            }

            // 4d. Pagamentos por cupom — marca como usado, registra pagamento
            if (cupons != null) {
                for (Cupom c : cupons) {
                    if (c == null || c.getValor() == null) continue;

                    BigDecimal valorCupom = c.getValor().setScale(2, RoundingMode.HALF_UP);
                    if (valorCupom.compareTo(BigDecimal.ZERO) <= 0) continue;

                    Pagamento pagCupom = new Pagamento();
                    pagCupom.setPedidoId(pedidoId);
                    pagCupom.setValor(valorCupom);
                    pagCupom.setTipo(c.getTipo());
                    pagCupom.setCodigoCupom(String.valueOf(c.getId()));
                    pagCupom.setStatus("APROVADO");
                    pagamentoDAO.inserir(pagCupom, con);
                    cupomDAO.marcarComoUsado(c.getId(), con);
                }
            }

            // 4e. Pagamento cartão 1
            if (v1.compareTo(BigDecimal.ZERO) > 0) {
                Pagamento pag1 = new Pagamento();
                pag1.setPedidoId(pedidoId);
                pag1.setCartaoId(cartao1Id);
                pag1.setValor(v1);
                pag1.setTipo("CARTAO");
                pag1.setParcelas(1);
                pag1.setStatus("APROVADO");
                pagamentoDAO.inserir(pag1, con);
            }

            // 4f. Pagamento cartão 2
            if (cartao2Id != null && v2.compareTo(BigDecimal.ZERO) > 0) {
                Pagamento pag2 = new Pagamento();
                pag2.setPedidoId(pedidoId);
                pag2.setCartaoId(cartao2Id);
                pag2.setValor(v2);
                pag2.setTipo("CARTAO");
                pag2.setParcelas(1);
                pag2.setStatus("APROVADO");
                pagamentoDAO.inserir(pag2, con);
            }

            con.commit();
            return pedidoId;

        } catch (Exception e) {
            con.rollback();
            throw e;
        } finally {
            con.close();
        }
    }

    /**
     * Calcula quais cupons devem ser usados para cobrir o valor alvo,
     * sem deixar sobra desnecessária.
     *
     * Regra: não se deve usar cupons que superem o total da compra.
     * Se o valor exato não for atingível, usa-se o subconjunto de menor
     * sobra. A sobra positiva gera um cupom de troca.
     *
     * Este método é chamado pelo PedidoController antes de chamar
     * finalizarCompra, para montar a lista correta de cupons.
     *
     * @param cuponsSelecionados cupons escolhidos pelo cliente
     * @param totalBruto         subtotal + frete (antes de qualquer desconto)
     * @return resultado com lista final de cupons a usar e valor de troca a gerar
     */
    public ResultadoCupom processarCupons(List<Cupom> cuponsSelecionados, BigDecimal totalBruto) {
        if (cuponsSelecionados == null || cuponsSelecionados.isEmpty()) {
            return new ResultadoCupom(List.of(), BigDecimal.ZERO, BigDecimal.ZERO);
        }

        BigDecimal somaCupons = cuponsSelecionados.stream()
                .map(Cupom::getValor)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        // Se a soma não ultrapassa o total: usa todos, sem troca
        if (somaCupons.compareTo(totalBruto) <= 0) {
            return new ResultadoCupom(cuponsSelecionados, somaCupons, BigDecimal.ZERO);
        }

        // Há sobra — calcula o troco
        BigDecimal troco = somaCupons.subtract(totalBruto).setScale(2, RoundingMode.HALF_UP);
        // Desconto efetivo é o totalBruto (cobre 100%)
        BigDecimal descontoEfetivo = totalBruto.setScale(2, RoundingMode.HALF_UP);
        return new ResultadoCupom(cuponsSelecionados, descontoEfetivo, troco);
    }

    /**
     * Gera um cupom de troca para o cliente com o valor de troco,
     * dentro de uma conexão/transação gerenciada externamente.
     */
    public Cupom gerarCupomTroca(int clienteId, BigDecimal valor, Connection con) throws Exception {
        return cupomDAO.gerarCupomTroca(clienteId, valor, con);
    }

    public static class ResultadoCupom {
        public final List<Cupom>   cuponsAUsar;
        public final BigDecimal    descontoTotal;
        public final BigDecimal    trocoParaGerarCupom; // 0 se não houver troca

        public ResultadoCupom(List<Cupom> cuponsAUsar, BigDecimal descontoTotal, BigDecimal trocoParaGerarCupom) {
            this.cuponsAUsar           = cuponsAUsar;
            this.descontoTotal         = descontoTotal;
            this.trocoParaGerarCupom   = trocoParaGerarCupom;
        }

        public boolean temTroco() {
            return trocoParaGerarCupom != null && trocoParaGerarCupom.compareTo(BigDecimal.ZERO) > 0;
        }
    }
}