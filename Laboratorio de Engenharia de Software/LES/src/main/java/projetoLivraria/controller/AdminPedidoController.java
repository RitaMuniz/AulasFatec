package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import projetoLivraria.dao.ClienteDAO;
import projetoLivraria.dao.ItemPedidoDAO;
import projetoLivraria.dao.PedidoDAO;
import projetoLivraria.model.Admin;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.ItemPedido;
import projetoLivraria.model.Pedido;
import projetoLivraria.uteis.ConexaoSQL;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

public class AdminPedidoController extends HttpServlet {

    private final PedidoDAO pedidoDAO = new PedidoDAO();
    private final ItemPedidoDAO itemPedidoDAO = new ItemPedidoDAO();
    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAdmin(req, resp)) return;

        String path = req.getServletPath();

        try (Connection con = ConexaoSQL.getInstance().getConnection()) {

            // /admin/pedidos?id=X → detalhe
            // /admin/pedidos?id=X&acao=editar → tela de edição
            // /admin/pedidos → lista
            // /admin → dashboard

            if (path.equals("/admin")) {
                List<Pedido> pedidos = pedidoDAO.listarTodos();
                carregarClientes(pedidos, con);
                req.setAttribute("pedidos", pedidos);
                req.getRequestDispatcher("/view/admin.jsp").forward(req, resp);
                return;
            }

            String idStr = req.getParameter("id");
            String acao  = req.getParameter("acao");

            if (idStr != null && !idStr.isEmpty()) {
                int pedidoId = Integer.parseInt(idStr);
                Pedido pedido = pedidoDAO.buscarPorIdAdmin(pedidoId);
                if (pedido == null) {
                    resp.sendRedirect(req.getContextPath() + "/admin/pedidos");
                    return;
                }
                Cliente cliente = clienteDAO.buscarPorId(con, pedido.getClienteId());
                pedido.setCliente(cliente);

                List<ItemPedido> itens = itemPedidoDAO.listarPorPedido(pedidoId);
                pedido.setItens(itens);

                req.setAttribute("pedido", pedido);

                if ("editar".equals(acao)) {
                    req.getRequestDispatcher("/view/admin-pedido-editar.jsp").forward(req, resp);
                } else {
                    req.getRequestDispatcher("/view/admin-pedido-detalhe.jsp").forward(req, resp);
                }

            } else {
                // lista todos
                List<Pedido> pedidos = pedidoDAO.listarTodos();
                carregarClientes(pedidos, con);

                String busca = req.getParameter("busca");
                if (busca != null && !busca.trim().isEmpty()) {
                    String termo = busca.trim().toLowerCase();
                    pedidos = pedidos.stream().filter(p ->
                            String.valueOf(p.getId()).contains(termo) ||
                                    (p.getCliente() != null && p.getCliente().getNome().toLowerCase().contains(termo))
                    ).toList();
                }

                req.setAttribute("pedidos", pedidos);
                req.setAttribute("busca", busca);
                req.getRequestDispatcher("/view/admin-pedidos.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if (!isAdmin(req, resp)) return;

        try {
            int pedidoId = Integer.parseInt(req.getParameter("pedido_id"));
            String novoStatus = req.getParameter("status");

            pedidoDAO.atualizarStatus(pedidoId, novoStatus);

            resp.sendRedirect(req.getContextPath() + "/admin/pedidos?id=" + pedidoId);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void carregarClientes(List<Pedido> pedidos, Connection con) throws Exception {
        for (Pedido p : pedidos) {
            Cliente c = clienteDAO.buscarPorId(con, p.getClienteId());
            p.setCliente(c);
        }
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