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

    /** GET /carrinho → exibe o carrinho ou remove item */
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

    /** POST /carrinho → adiciona item com quantidade ou atualiza quantidade existente */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            int livroId = Integer.parseInt(req.getParameter("livroId"));
            String acao = req.getParameter("acao");

            HttpSession session = req.getSession();
            Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
            if (carrinho == null) {
                carrinho = new Carrinho();
            }

            if ("atualizar".equals(acao)) {
                int quantidade = Integer.parseInt(req.getParameter("quantidade"));
                Livro livro = livroDAO.buscarPorId(livroId);
                if (livro != null) {
                    int estoqueMax = livro.getEstoque() != null ? livro.getEstoque() : 0;
                    quantidade = Math.min(quantidade, estoqueMax);
                    quantidade = Math.max(quantidade, 1);
                    carrinho.atualizarQuantidade(livroId, quantidade);
                }
                session.setAttribute("carrinho", carrinho);
                resp.sendRedirect(req.getContextPath() + "/carrinho");
                return;
            }

            Livro livro = livroDAO.buscarPorId(livroId);
            if (livro == null) {
                resp.sendRedirect(req.getContextPath() + "/livros");
                return;
            }

            String qtdStr = req.getParameter("quantidade");
            int quantidade = (qtdStr != null && !qtdStr.isEmpty()) ? Integer.parseInt(qtdStr) : 1;
            int estoqueMax = livro.getEstoque() != null ? livro.getEstoque() : 0;
            quantidade = Math.min(quantidade, estoqueMax);
            quantidade = Math.max(quantidade, 1);

            carrinho.adicionarItem(livro, quantidade);
            session.setAttribute("carrinho", carrinho);

            resp.sendRedirect(req.getContextPath() + "/carrinho");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}