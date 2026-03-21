package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import projetoLivraria.model.Cliente;
import projetoLivraria.service.ClienteService;

import java.io.IOException;

public class LoginController extends HttpServlet {

    private final ClienteService service = new ClienteService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("clienteLogado") != null) {
            resp.sendRedirect(req.getContextPath() + "/view/cliente.jsp");
            return;
        }
        resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        try {
            Cliente cliente = service.buscarClientePorEmail(email);

            if (cliente == null || !cliente.getSenha().equals(senha)) {
                // Volta ao login com flag de erro na URL
                resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
                return;
            }

            HttpSession session = req.getSession();
            session.setAttribute("clienteLogado", cliente);
            session.setMaxInactiveInterval(30 * 60);

            resp.sendRedirect(req.getContextPath() + "/view/cliente.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao realizar login.");
        }
    }
}