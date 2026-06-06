package projetoLivraria.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import projetoLivraria.dao.RelatorioDAO;
import projetoLivraria.dao.RelatorioDAO.VendaCategoriaMes;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Endpoint: GET /relatorio-vendas
 *
 * Parâmetros opcionais:
 *   inicio  – data inicial no formato YYYY-MM-DD
 *   fim     – data final   no formato YYYY-MM-DD
 *
 * Responde com JSON no formato:
 *   [{"mes":"2025-01","categoria":"Romance","total":12}, ...]
 */
public class RelatorioVendasController extends HttpServlet {

    private final RelatorioDAO relatorioDAO = new RelatorioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        // Apenas admins podem acessar este endpoint
        if (req.getSession(false) == null
                || req.getSession(false).getAttribute("adminLogado") == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Acesso negado");
            return;
        }

        String inicio = req.getParameter("inicio");
        String fim    = req.getParameter("fim");

        resp.setContentType("application/json;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("Cache-Control", "no-store");

        try {
            List<VendaCategoriaMes> dados = relatorioDAO.buscarVendasPorCategoriaMes(inicio, fim);
            PrintWriter out = resp.getWriter();
            out.print(toJson(dados));
            out.flush();

        } catch (Exception e) {
            // Loga a causa real no console do Tomcat para diagnóstico
            getServletContext().log("[RelatorioVendasController] Erro ao gerar relatorio", e);
            e.printStackTrace();

            // Garante que o body nunca fique vazio para o JS mostrar a mensagem
            if (!resp.isCommitted()) {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.setContentType("application/json;charset=UTF-8");
            }
            try {
                PrintWriter out = resp.getWriter();
                out.print("{\"erro\":\"" + e.getClass().getSimpleName()
                        + ": " + jsonEscape(e.getMessage()) + "\"}");
                out.flush();
            } catch (IOException ignored) {}
        }
    }

    // -----------------------------------------------------------------------
    // Serialização JSON manual (sem dependência extra de biblioteca)
    // -----------------------------------------------------------------------

    private String toJson(List<VendaCategoriaMes> lista) {
        if (lista.isEmpty()) return "[]";

        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < lista.size(); i++) {
            VendaCategoriaMes v = lista.get(i);
            sb.append("{")
                    .append("\"mes\":").append(jsonStr(v.mes)).append(",")
                    .append("\"categoria\":").append(jsonStr(v.categoria)).append(",")
                    .append("\"total\":").append(v.total)
                    .append("}");
            if (i < lista.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }

    private String jsonStr(String s) {
        if (s == null) return "null";
        return "\"" + jsonEscape(s) + "\"";
    }

    private String jsonEscape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }
}