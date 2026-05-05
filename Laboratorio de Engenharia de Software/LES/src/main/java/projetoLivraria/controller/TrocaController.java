package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import projetoLivraria.dao.*;
import projetoLivraria.model.*;
import projetoLivraria.uteis.ConexaoSQL;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.List;

/**
 * /troca
 *
 * GET  ?action=listar                       → lista trocas do cliente logado
 * GET  ?action=solicitar&pedidoId=X         → exibe form de solicitação
 * POST action=solicitar                     → cria a troca (status SOLICITADA)
 *
 * Admin (requer session "adminLogado"):
 * GET  ?action=admin                        → lista todas as trocas
 * POST action=aprovar   &trocaId=X          → SOLICITADA → APROVADA
 * POST action=receber   &trocaId=X          → APROVADA   → RECEBIDA
 * POST action=concluir  &trocaId=X          → RECEBIDA   → CONCLUIDA + gera cupom
 * POST action=recusar   &trocaId=X&motivo=Y → qualquer   → RECUSADA
 */
public class TrocaController extends HttpServlet {

    private final TrocaDAO      trocaDAO      = new TrocaDAO();
    private final PedidoDAO     pedidoDAO     = new PedidoDAO();
    private final ItemPedidoDAO itemPedidoDAO = new ItemPedidoDAO();
    private final CupomDAO      cupomDAO      = new CupomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "listar";

        switch (action) {
            case "admin"     -> handleAdminListar(req, resp);
            case "solicitar" -> handleSolicitarForm(req, resp);
            default          -> handleClienteListar(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "solicitar" -> handleSolicitarPost(req, resp);
            case "aprovar"   -> handleAdminTransicao(req, resp, Troca.STATUS_APROVADA);
            case "receber"   -> handleAdminTransicao(req, resp, Troca.STATUS_RECEBIDA);
            case "concluir"  -> handleAdminConcluir(req, resp);
            case "recusar"   -> handleAdminTransicao(req, resp, Troca.STATUS_RECUSADA);
            default          -> resp.sendRedirect(req.getContextPath() + "/troca");
        }
    }

    /** Lista trocas do cliente logado. */
    private void handleClienteListar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Cliente cliente = clienteLogado(req, resp);
        if (cliente == null) return;

        try {
            List<Troca> trocas = trocaDAO.listarPorCliente(cliente.getId());
            req.setAttribute("trocas", trocas);
            req.getRequestDispatcher("/view/trocas.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /**
     * Exibe o formulário de confirmação de troca.
     * O item já vem definido pela URL (pedido.jsp passa pedidoId + itemPedidoId).
     */
    private void handleSolicitarForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Cliente cliente = clienteLogado(req, resp);
        if (cliente == null) return;

        String pedidoIdStr = req.getParameter("pedidoId");
        String itemIdStr   = req.getParameter("itemPedidoId");

        if (pedidoIdStr == null || pedidoIdStr.isBlank()
                || itemIdStr == null || itemIdStr.isBlank()) {
            resp.sendRedirect(req.getContextPath() + "/pedidos");
            return;
        }

        try {
            int pedidoId = Integer.parseInt(pedidoIdStr);
            int itemId   = Integer.parseInt(itemIdStr);

            Pedido pedido = pedidoDAO.buscarPorId(pedidoId, cliente.getId());
            if (pedido == null) {
                resp.sendRedirect(req.getContextPath() + "/pedidos");
                return;
            }
            if (!"ENTREGUE".equals(pedido.getStatus())) {
                resp.sendRedirect(req.getContextPath() + "/pedidos?id=" + pedidoId);
                return;
            }

            try (Connection con = ConexaoSQL.getInstance().getConnection()) {
                ItemPedido item = itemPedidoDAO.buscarPorId(itemId, con);
                if (item == null || item.getPedidoId() != pedidoId) {
                    resp.sendRedirect(req.getContextPath() + "/pedidos?id=" + pedidoId);
                    return;
                }
                if (item.getStatusTroca() != null && !item.getStatusTroca().isBlank()) {
                    resp.sendRedirect(req.getContextPath() + "/pedidos?id=" + pedidoId);
                    return;
                }
                req.setAttribute("pedido", pedido);
                req.setAttribute("item",   item);
            }

            req.getRequestDispatcher("/view/troca-solicitar.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /** Cria a solicitação de troca. */
    private void handleSolicitarPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Cliente cliente = clienteLogado(req, resp);
        if (cliente == null) return;

        try {
            int pedidoId     = Integer.parseInt(req.getParameter("pedidoId"));
            int itemPedidoId = Integer.parseInt(req.getParameter("itemPedidoId"));
            String motivo    = req.getParameter("motivo");

            // Valida que o pedido pertence ao cliente e está entregue
            Pedido pedido = pedidoDAO.buscarPorId(pedidoId, cliente.getId());
            if (pedido == null || !"ENTREGUE".equals(pedido.getStatus())) {
                resp.sendRedirect(req.getContextPath() + "/pedidos");
                return;
            }

            Troca troca = new Troca();
            troca.setPedidoId(pedidoId);
            troca.setItemPedidoId(itemPedidoId);
            troca.setMotivo(motivo);

            try (Connection con = ConexaoSQL.getInstance().getConnection()) {
                con.setAutoCommit(false);
                try {
                    trocaDAO.inserir(troca, con);
                    // Marca o item como em processo de troca
                    itemPedidoDAO.atualizarStatusTroca(itemPedidoId, "EM_TROCA", con);
                    con.commit();
                } catch (Exception e) {
                    con.rollback();
                    throw e;
                }
            }

            resp.sendRedirect(req.getContextPath() + "/troca?action=listar&sucesso=1");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /** Lista todas as trocas (painel admin). */
    private void handleAdminListar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAdmin(req, resp)) return;

        try {
            List<Troca> trocas = trocaDAO.listarTodas();
            req.setAttribute("trocas", trocas);
            req.getRequestDispatcher("/view/admin-devolucoes.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /** Transições simples: aprovar / receber / recusar. */
    private void handleAdminTransicao(HttpServletRequest req, HttpServletResponse resp,
                                      String novoStatus)
            throws ServletException, IOException {

        if (!isAdmin(req, resp)) return;

        try {
            int trocaId = Integer.parseInt(req.getParameter("trocaId"));
            try (Connection con = ConexaoSQL.getInstance().getConnection()) {
                con.setAutoCommit(false);
                try {
                    trocaDAO.atualizarStatus(trocaId, novoStatus, con);

                    // Se recusado, libera o status do item
                    if (Troca.STATUS_RECUSADA.equals(novoStatus)) {
                        Troca troca = trocaDAO.buscarPorId(trocaId, con);
                        if (troca != null) {
                            itemPedidoDAO.atualizarStatusTroca(troca.getItemPedidoId(), null, con);
                        }
                    }

                    con.commit();
                } catch (Exception e) {
                    con.rollback();
                    throw e;
                }
            }
            String sucesso = switch (novoStatus) {
                case Troca.STATUS_APROVADA  -> "aprovada";
                case Troca.STATUS_RECEBIDA  -> "recebida";
                case Troca.STATUS_RECUSADA  -> "recusada";
                default                     -> "";
            };
            resp.sendRedirect(req.getContextPath() + "/troca?action=admin&sucesso=" + sucesso);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /**
     * Conclui a troca: status CONCLUIDA + gera cupom de troca com o valor
     * do item devolvido.
     */
    private void handleAdminConcluir(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAdmin(req, resp)) return;

        try {
            int trocaId = Integer.parseInt(req.getParameter("trocaId"));

            try (Connection con = ConexaoSQL.getInstance().getConnection()) {
                con.setAutoCommit(false);
                try {
                    Troca troca = trocaDAO.buscarPorId(trocaId, con);
                    if (troca == null || !Troca.STATUS_RECEBIDA.equals(troca.getStatus())) {
                        con.rollback();
                        resp.sendRedirect(req.getContextPath() + "/troca?action=admin&erro=troca_invalida");
                        return;
                    }

                    // Busca o item para saber o valor do reembolso
                    ItemPedido item = itemPedidoDAO.buscarPorId(troca.getItemPedidoId(), con);
                    if (item == null) {
                        con.rollback();
                        resp.sendRedirect(req.getContextPath() + "/troca?action=admin&erro=item_nao_encontrado");
                        return;
                    }

                    // Valor do cupom = preço unitário × quantidade do item trocado
                    BigDecimal valorReembolso = item.getPrecoUnitario()
                            .multiply(BigDecimal.valueOf(item.getQuantidade()));

                    // Busca o cliente dono do pedido
                    Pedido pedido = pedidoDAO.buscarPorIdAdmin(troca.getPedidoId());
                    int clienteId = pedido.getClienteId();

                    // Gera cupom de troca
                    Cupom cupomTroca = cupomDAO.gerarCupomTroca(clienteId, valorReembolso, con);

                    // Atualiza troca como concluída
                    trocaDAO.concluir(trocaId, cupomTroca.getId(), con);

                    // Atualiza status do item
                    itemPedidoDAO.atualizarStatusTroca(item.getId(), "TROCADO", con);

                    // Devolve ao estoque (ainda não sei se vai ser devolvido ao estoque)
                    // estoqueDAO.incrementar(item.getLivroId(), item.getQuantidade(), con);

                    con.commit();
                } catch (Exception e) {
                    con.rollback();
                    throw e;
                }
            }

            resp.sendRedirect(req.getContextPath() + "/troca?action=admin&sucesso=concluida");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private Cliente clienteLogado(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("clienteLogado") == null) {
            resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
            return null;
        }
        return (Cliente) session.getAttribute("clienteLogado");
    }

    private boolean isAdmin(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminLogado") == null) {
            resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
            return false;
        }
        return true;
    }
}