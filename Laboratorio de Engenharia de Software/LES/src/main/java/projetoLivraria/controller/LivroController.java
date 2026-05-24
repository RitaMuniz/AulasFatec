package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import projetoLivraria.dao.LivroDAO;
import projetoLivraria.model.Categoria;
import projetoLivraria.model.Livro;

import java.io.IOException;
import java.util.List;

public class LivroController extends HttpServlet {

    private LivroDAO livroDAO = new LivroDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        try {
            if (path.equals("/home")) {

                List<Livro> maisVendidos = livroDAO.listarMaisVendidos(8);
                req.setAttribute("livros", maisVendidos);
                req.getRequestDispatcher("/view/index.jsp").forward(req, resp);

            } else if (path.equals("/livros")) {

                String busca      = req.getParameter("busca");
                String categoriaId = req.getParameter("categoriaId");

                boolean temFiltro = (busca != null && !busca.trim().isEmpty())
                        || (categoriaId != null && !categoriaId.trim().isEmpty());

                List<Livro> livros = temFiltro
                        ? livroDAO.buscarComFiltros(busca, categoriaId)
                        : livroDAO.listarTodos();

                List<Categoria> categorias = livroDAO.listarCategorias();

                req.setAttribute("livros", livros);
                req.setAttribute("categorias", categorias);
                req.setAttribute("buscaAtual", busca != null ? busca : "");
                req.setAttribute("categoriaIdAtual", categoriaId != null ? categoriaId : "");

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