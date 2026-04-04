package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import projetoLivraria.dao.ItemPedidoDAO;
import projetoLivraria.dao.PedidoDAO;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.ItemPedido;
import projetoLivraria.model.Pedido;

import java.io.IOException;
import java.util.List;

public class PedidosController extends HttpServlet {

    private final PedidoDAO pedidoDAO = new PedidoDAO();
    private final ItemPedidoDAO itemPedidoDAO = new ItemPedidoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Cliente cliente = (Cliente) session.getAttribute("clienteLogado");

        if (cliente == null) {
            resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
            return;
        }

        try {
            String idStr = req.getParameter("id");

            // detalhe de um pedido específico
            if (idStr != null && !idStr.isEmpty()) {
                int pedidoId = Integer.parseInt(idStr);
                Pedido pedido = pedidoDAO.buscarPorId(pedidoId, cliente.getId());

                if (pedido == null) {
                    resp.sendRedirect(req.getContextPath() + "/pedidos");
                    return;
                }

                List<ItemPedido> itens = itemPedidoDAO.listarPorPedido(pedidoId);
                req.setAttribute("pedido", pedido);
                req.setAttribute("itens", itens);
                req.getRequestDispatcher("/view/pedido.jsp").forward(req, resp);

            } else {
                // lista todos os pedidos do cliente
                List<Pedido> pedidos = pedidoDAO.listarPorCliente(cliente.getId());
                System.out.println("Pedidos encontrados: " + pedidos.size() + " para cliente id: " + cliente.getId());
                req.setAttribute("pedidos", pedidos);
                req.getRequestDispatcher("/view/pedidos.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}