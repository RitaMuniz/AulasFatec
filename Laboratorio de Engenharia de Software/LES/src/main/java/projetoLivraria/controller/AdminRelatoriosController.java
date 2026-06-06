package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import projetoLivraria.dao.RelatorioDAO;
import projetoLivraria.model.Admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;


public class AdminRelatoriosController extends HttpServlet {

    private final RelatorioDAO relatorioDAO = new RelatorioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // -------------------------------------------------------------------
        // Proteção: só admin pode acessar
        // Ajuste o atributo de sessão conforme o seu LoginController usa
        // -------------------------------------------------------------------
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("adminLogado") == null) {
            resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
            return;
        }

        String dataInicial = req.getParameter("dataInicial");
        String dataFinal   = req.getParameter("dataFinal");

        try {
            double faturamento    = relatorioDAO.getFaturamentoTotal(dataInicial, dataFinal);
            int    totalPedidos   = relatorioDAO.getTotalPedidos(dataInicial, dataFinal);
            int    clientesAtivos = relatorioDAO.getClientesAtivos();
            String livroTop       = relatorioDAO.getLivroMaisVendido(dataInicial, dataFinal);
            List<Map<String, Object>> vendas = relatorioDAO.getHistoricoVendas(dataInicial, dataFinal);

            req.setAttribute("faturamento",    faturamento);
            req.setAttribute("totalPedidos",   totalPedidos);
            req.setAttribute("clientesAtivos", clientesAtivos);
            req.setAttribute("livroTop",       livroTop);
            req.setAttribute("vendas",         vendas);
            req.setAttribute("dataInicial",    dataInicial != null ? dataInicial : "");
            req.setAttribute("dataFinal",      dataFinal   != null ? dataFinal   : "");

        } catch (Exception e) {
            throw new ServletException("Erro ao gerar relatório", e);
        }

        req.getRequestDispatcher("/view/admin-relatorios.jsp").forward(req, resp);
    }
}