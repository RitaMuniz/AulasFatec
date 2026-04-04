package projetoLivraria.service;

import projetoLivraria.dao.*;
import projetoLivraria.model.*;
import projetoLivraria.uteis.ConexaoSQL;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.util.List;

public class PedidoService {

    private final PedidoDAO pedidoDAO = new PedidoDAO();
    private final ItemPedidoDAO itemPedidoDAO = new ItemPedidoDAO();
    private final PagamentoDAO pagamentoDAO = new PagamentoDAO();
    private final CupomDAO cupomDAO = new CupomDAO();
    private final CarrinhoDAO carrinhoDAO = new CarrinhoDAO();

    public int finalizarCompra(
            int clienteId,
            int enderecoId,
            Carrinho carrinho,
            BigDecimal frete,
            Integer cartao1Id, BigDecimal valorCartao1,
            Integer cartao2Id, BigDecimal valorCartao2,
            Cupom cupom
    ) throws Exception {

        List<ItemCarrinho> itens = carrinho.getItens();
        if (itens == null || itens.isEmpty()) {
            throw new Exception("Carrinho vazio.");
        }
        BigDecimal subtotal = itens.stream()
                .map(ItemCarrinho::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal totalBruto = subtotal.add(frete);

        BigDecimal desconto = BigDecimal.ZERO;
        if (cupom != null && cupom.getValor() != null) {
            desconto = cupom.getValor().min(totalBruto).setScale(2, RoundingMode.HALF_UP);
        }

        BigDecimal total = totalBruto.subtract(desconto).setScale(2, RoundingMode.HALF_UP);

        BigDecimal somaCartoes = BigDecimal.ZERO;
        if (valorCartao1 != null) somaCartoes = somaCartoes.add(valorCartao1);
        if (valorCartao2 != null) somaCartoes = somaCartoes.add(valorCartao2);

        if (somaCartoes.compareTo(total) != 0) {
            throw new Exception("Pagamento inválido: soma dos cartões diferente do total.");
        }

        Connection con = ConexaoSQL.getInstance().getConnection();
        con.setAutoCommit(false);

        try {

            // 1. Pedido
            Pedido pedido = new Pedido();
            pedido.setClienteId(clienteId);
            pedido.setEnderecoEntregaId(enderecoId);
            pedido.setSubtotal(subtotal);
            pedido.setFrete(frete);
            pedido.setDesconto(desconto);
            pedido.setTotal(total);
            pedido.setStatus("EM_PROCESSAMENTO");

            int pedidoId = pedidoDAO.inserir(pedido, con);

            // 2. Itens + estoque
            for (ItemCarrinho ic : itens) {

                ItemPedido item = new ItemPedido();
                item.setPedidoId(pedidoId);
                item.setLivroId(ic.getLivroId());
                item.setQuantidade(ic.getQuantidade());
                item.setPrecoUnitario(ic.getPrecoUnitario());

                itemPedidoDAO.inserir(item, con);
            }

            // 3. Cupom
            if (cupom != null && desconto.compareTo(BigDecimal.ZERO) > 0) {
                Pagamento pagCupom = new Pagamento();
                pagCupom.setPedidoId(pedidoId);
                pagCupom.setValor(desconto);
                pagCupom.setTipo(cupom.getTipo());
                pagCupom.setCodigoCupom(String.valueOf(cupom.getId()));
                pagCupom.setStatus("APROVADO");
                pagamentoDAO.inserir(pagCupom, con);
                cupomDAO.marcarComoUsado(cupom.getId(), con);
            }

            // 4. Cartão 1
            if (cartao1Id != null && valorCartao1 != null && valorCartao1.compareTo(BigDecimal.ZERO) > 0) {
                Pagamento pag1 = new Pagamento();
                pag1.setPedidoId(pedidoId);
                pag1.setCartaoId(cartao1Id);
                pag1.setValor(valorCartao1);
                pag1.setTipo("CARTAO");
                pag1.setParcelas(1);
                pag1.setStatus("APROVADO");

                pagamentoDAO.inserir(pag1, con);
            }
            // 5. Cartão 2
            if (cartao2Id != null && valorCartao2 != null && valorCartao2.compareTo(BigDecimal.ZERO) > 0) {
                Pagamento pag2 = new Pagamento();
                pag2.setPedidoId(pedidoId);
                pag2.setCartaoId(cartao2Id);
                pag2.setValor(valorCartao2);
                pagamentoDAO.inserir(pag2, con);
            }

            carrinhoDAO.atualizarStatus(carrinho.getId(), "FINALIZADO", con);

            con.commit();
            return pedidoId;

        } catch (Exception e) {
            con.rollback();
            throw e;
        }
    }
}
