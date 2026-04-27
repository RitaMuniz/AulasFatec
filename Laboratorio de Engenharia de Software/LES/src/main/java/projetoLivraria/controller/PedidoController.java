package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import projetoLivraria.dao.*;
import projetoLivraria.model.*;
import projetoLivraria.service.PedidoService;
import projetoLivraria.uteis.ConexaoSQL;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class PedidoController extends HttpServlet {

    private final EnderecoDAO enderecoDAO = new EnderecoDAO();
    private final CartaoDAO cartaoDAO = new CartaoDAO();
    private final CupomDAO cupomDAO = new CupomDAO();
    private final PedidoService pedidoService = new PedidoService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");

        if (carrinho == null || carrinho.getItens().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/carrinho");
            return;
        }

        Cliente cliente = (Cliente) session.getAttribute("clienteLogado");
        if (cliente == null) {
            resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
            return;
        }

        try (Connection con = ConexaoSQL.getInstance().getConnection()) {
            List<Endereco> enderecos = enderecoDAO.listarPorCliente(con, cliente.getId());
            List<Cartao>   cartoes   = cartaoDAO.listarPorCliente(con, cliente.getId());
            List<Cupom>    cupons    = cupomDAO.listarDisponiveisPorCliente(cliente.getId());

            // Calcula subtotal para exibir frete estimado na UI
            // (frete definitivo é calculado no POST quando o CEP é conhecido)
            BigDecimal subtotal = carrinho.getItens().stream()
                    .map(ItemCarrinho::getSubtotal)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            req.setAttribute("subtotalCarrinho", subtotal);

            req.setAttribute("enderecos", enderecos);
            req.setAttribute("cartoes", cartoes);
            req.setAttribute("cupons", cupons);

            req.getRequestDispatcher("/view/checkout.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    //POST: processa o pedido

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        try {
            HttpSession session = req.getSession();
            Cliente cliente = (Cliente) session.getAttribute("clienteLogado");
            Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");

            if (cliente == null || carrinho == null || carrinho.getItens().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
                return;
            }

            //Endereço
            int enderecoId = Integer.parseInt(req.getParameter("endereco_id"));

            // Busca CEP do endereço para calcular o frete
            String cepEntrega = "";
            try (Connection con = ConexaoSQL.getInstance().getConnection()) {
                Endereco end = enderecoDAO.buscarPorId(con, enderecoId);
                if (end != null && end.getCep() != null) {
                    cepEntrega = end.getCep();
                }
            }

            //Frete calculado
            double pesoTotal = carrinho.getItens().stream()
                    .map(ic -> {
                        if (ic.getLivro() != null && ic.getLivro().getPeso() != null) {
                            return ic.getLivro().getPeso()
                                    .multiply(BigDecimal.valueOf(ic.getQuantidade()));
                        }
                        return BigDecimal.ZERO;
                    })
                    .reduce(BigDecimal.ZERO, BigDecimal::add)
                    .doubleValue();

            BigDecimal frete = pedidoService.calcularFrete(cepEntrega, pesoTotal);

            // Cartões
            int cartao1Id = Integer.parseInt(req.getParameter("cartao1_id"));
            BigDecimal valor1 = parseMoeda(req.getParameter("valor_cartao1"));

            Integer cartao2Id = null;
            BigDecimal valor2 = null;
            String cartao2Str = req.getParameter("cartao2_id");
            String valor2Str  = req.getParameter("valor_cartao2");
            if (cartao2Str != null && !cartao2Str.isBlank()) {
                cartao2Id = Integer.parseInt(cartao2Str);
                valor2    = parseMoeda(valor2Str);
            }

            //Cupons (múltiplos)
            String[] cupomIds = req.getParameterValues("cupom_id");
            List<Cupom> cuponsEscolhidos = new ArrayList<>();
            if (cupomIds != null) {
                for (String idStr : cupomIds) {
                    if (idStr != null && !idStr.isBlank()) {
                        Cupom c = cupomDAO.buscarPorId(Integer.parseInt(idStr));
                        if (c != null && c.isDisponivel()) {
                            cuponsEscolhidos.add(c);
                        }
                    }
                }
            }

            // ── Processa cupons (valida sobra, gera cupom de troca se necessário) ──
            BigDecimal subtotal = carrinho.getItens().stream()
                    .map(ItemCarrinho::getSubtotal)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            BigDecimal totalBruto = subtotal.add(frete);

            PedidoService.ResultadoCupom resultadoCupom =
                    pedidoService.processarCupons(cuponsEscolhidos, totalBruto);

            if (resultadoCupom.temTroco()) {
                // Gera o cupom de troca dentro de uma transação separada
                // (o finalizarCompra vai abrir a transação principal)
                // Guardamos o troco na sessão para exibir na confirmação.
                session.setAttribute("trocoCupom", resultadoCupom.trocoParaGerarCupom);
            }

            // ── Finaliza a compra ─────────────────────────────────────────────
            // Obs: a geração do cupom de troca ocorre dentro do finalizarCompra
            // para garantir atomicidade. Passamos o troco como parâmetro extra.
            int pedidoId = finalizarComTroco(
                    cliente.getId(),
                    enderecoId,
                    carrinho,
                    frete,
                    cartao1Id, valor1,
                    cartao2Id, valor2,
                    resultadoCupom
            );

            session.removeAttribute("carrinho");
            session.setAttribute("pedidoId", pedidoId);
            session.setAttribute("freteCalculado", frete);

            resp.sendRedirect(req.getContextPath() + "/view/confirmacao.html");

        } catch (IllegalArgumentException e) {
            // Erros de validação de negócio — podemos exibir mensagem amigável
            req.getSession().setAttribute("erroCheckout", e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/pedido");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("erroCheckout", "Erro ao processar pedido: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/pedido");
        }
    }

    // ── Helper: finalizar com geração de cupom de troca na mesma transação ───

    private int finalizarComTroco(
            int clienteId,
            int enderecoId,
            Carrinho carrinho,
            BigDecimal frete,
            Integer cartao1Id, BigDecimal valor1,
            Integer cartao2Id, BigDecimal valor2,
            PedidoService.ResultadoCupom resultadoCupom
    ) throws Exception {

        // Chama o service principal
        int pedidoId = pedidoService.finalizarCompra(
                clienteId,
                enderecoId,
                carrinho,
                frete,
                cartao1Id, valor1,
                cartao2Id, valor2,
                resultadoCupom.cuponsAUsar
        );

        // Gera cupom de troca em transação separada (pedido já commitado)
        if (resultadoCupom.temTroco()) {
            try (Connection con = ConexaoSQL.getInstance().getConnection()) {
                con.setAutoCommit(false);
                try {
                    pedidoService.gerarCupomTroca(clienteId, resultadoCupom.trocoParaGerarCupom, con);
                    con.commit();
                } catch (Exception e) {
                    con.rollback();
                    // Não interrompe o fluxo — pedido já foi criado com sucesso.
                    // Log do erro é suficiente aqui.
                    System.err.println("[WARN] Falha ao gerar cupom de troca: " + e.getMessage());
                }
            }
        }

        return pedidoId;
    }

    // ── Helper: parse de valor monetário ("50,00" ou "50.00") ────────────────

    private BigDecimal parseMoeda(String valor) {
        if (valor == null || valor.isBlank()) return BigDecimal.ZERO;
        return new BigDecimal(valor.replace(",", ".").trim());
    }
}