package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import projetoLivraria.dao.AdminDAO;
import projetoLivraria.model.Admin;
import projetoLivraria.model.Cliente;
import projetoLivraria.service.ClienteService;
import projetoLivraria.uteis.ConexaoSQL;

import java.io.IOException;
import java.sql.Connection;

public class LoginController extends HttpServlet {

    private final ClienteService service = new ClienteService();
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            if (session.getAttribute("adminLogado") != null) {
                resp.sendRedirect(req.getContextPath() + "/view/admin.jsp");
                return;
            }
            if (session.getAttribute("clienteLogado") != null) {
                resp.sendRedirect(req.getContextPath() + "/view/index.jsp");
                return;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        try {
            Connection conn = ConexaoSQL.getInstance().getConnection();

            Admin admin = adminDAO.buscarPorEmail(conn, email);
            conn.close();

            if (admin != null && admin.getSenha().equals(senha)) {
                HttpSession session = req.getSession();
                session.setAttribute("adminLogado", admin);
                session.setMaxInactiveInterval(30 * 60);
                resp.sendRedirect(req.getContextPath() + "/view/admin.jsp");
                return;
            }

            Cliente cliente = service.buscarClientePorEmail(email);
            if (cliente != null && cliente.getSenha().equals(senha)) {
                if ("INATIVO".equalsIgnoreCase(cliente.getStatus())) {
                    resp.sendRedirect(req.getContextPath() + "/view/login.jsp?erro=2");
                    return;
                }
                HttpSession session = req.getSession();
                session.setAttribute("clienteLogado", cliente);
                session.setMaxInactiveInterval(30 * 60);
                resp.sendRedirect(req.getContextPath() + "/view/index.jsp");
                return;
            }

            resp.sendRedirect(req.getContextPath() + "/view/login.jsp?erro=1");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao realizar login.");
        }
    }
}