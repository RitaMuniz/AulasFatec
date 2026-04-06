package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import projetoLivraria.dao.LivroDAO;
import projetoLivraria.model.Livro;

import java.io.IOException;
import java.util.List;

public class LivroController extends HttpServlet {

    private LivroDAO livroDAO = new LivroDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        try {
            if (path.equals("/livros")) {

                List<Livro> livros = livroDAO.listarTodos();
                req.setAttribute("livros", livros);
                req.getRequestDispatcher("/view/livros.jsp").forward(req, resp);

            } else if (path.equals("/livro")) {

                int id = Integer.parseInt(req.getParameter("id"));
                Livro livro = livroDAO.buscarPorId(id);

                req.setAttribute("livro", livro);
                req.getRequestDispatcher("/view/detalhe.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
