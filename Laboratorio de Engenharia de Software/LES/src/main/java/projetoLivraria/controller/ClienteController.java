package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ClienteController", urlPatterns = {"/cliente"})

public class ClienteController extends HttpServlet {

    @Override
    protected void doGet (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try{
            if (action == null || action.equals("list")) {
                req.getRequestDispatcher("/cliente_list.jsp").forward(req, resp);
                return;
            }

            if (action.equals("form")) {
                req.getRequestDispatcher("/cliente_form.jsp").forward(req, resp);
                return;
            }

        } catch (Exception e) {
            req.setAttribute("erro", e.getMessage());
            req.getRequestDispatcher("/cliente_list.jsp").forward(req,resp);
        }
    }

    protected void doPost (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
    }
}
