package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import projetoLivraria.dao.LivroDAO;
import projetoLivraria.model.Carrinho;
import projetoLivraria.model.Livro;

import java.io.IOException;

public class CarrinhoController extends HttpServlet {

    private final LivroDAO livroDAO = new LivroDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String acao = req.getParameter("acao");
        if ("remover".equals(acao)) {
            int livroId = Integer.parseInt(req.getParameter("livroId"));
            HttpSession session = req.getSession();
            Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
            if (carrinho != null) {
                carrinho.removerItem(livroId);
            }
            resp.sendRedirect(req.getContextPath() + "/carrinho");
            return;
        }

        req.getRequestDispatcher("/view/carrinho.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int livroId = Integer.parseInt(req.getParameter("livroId"));
            Livro livro = livroDAO.buscarPorId(livroId);

            if (livro == null) {
                resp.sendRedirect(req.getContextPath() + "/livros");
                return;
            }

            HttpSession session = req.getSession();
            Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
            if (carrinho == null) {
                carrinho = new Carrinho();
            }

            carrinho.adicionarItem(livro);
            session.setAttribute("carrinho", carrinho);

            resp.sendRedirect(req.getContextPath() + "/carrinho");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}