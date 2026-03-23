package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import projetoLivraria.dao.BandeiraDAO;
import projetoLivraria.dao.CartaoDAO;
import projetoLivraria.model.Bandeira;
import projetoLivraria.model.Cartao;
import projetoLivraria.model.Cliente;
import projetoLivraria.uteis.ConexaoSQL;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

public class CartaoController extends HttpServlet {

    private final CartaoDAO cartaoDAO = new CartaoDAO();
    private final BandeiraDAO bandeiraDAO = new BandeiraDAO();

    private Cliente getClienteLogado(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("clienteLogado") == null) {
            resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
            return null;
        }
        return (Cliente) session.getAttribute("clienteLogado");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cliente clienteLogado = getClienteLogado(req, resp);
        if (clienteLogado == null) return;

        String action = req.getParameter("action");
        if (action == null) action = "listar";

        try {
            switch (action) {
                case "listar":
                    Connection conn = ConexaoSQL.getInstance().getConnection();
                    List<Cartao> cartoes = cartaoDAO.listarPorCliente(conn, clienteLogado.getId());
                    List<Bandeira> bandeiras = bandeiraDAO.listarTodas(conn);
                    conn.close();

                    req.setAttribute("cartoes", cartoes);
                    req.setAttribute("bandeiras", bandeiras);
                    req.getRequestDispatcher("/view/cartoes.jsp").forward(req, resp);
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/cartao?action=listar");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao listar cartões.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        Cliente clienteLogado = getClienteLogado(req, resp);
        if (clienteLogado == null) return;

        String action = req.getParameter("action");
        if (action == null) action = "adicionar";

        try {
            switch (action) {

                case "adicionar":
                    Cartao novo = new Cartao();
                    novo.setClienteId(clienteLogado.getId());
                    novo.setNumero(req.getParameter("numeroCartao"));
                    novo.setNomeImpresso(req.getParameter("nomeImpresso"));
                    novo.setBandeiraId(Integer.parseInt(req.getParameter("bandeiraId")));
                    novo.setValidade(req.getParameter("validade"));
                    novo.setCvv(req.getParameter("cvv"));

                    Connection connAdd = ConexaoSQL.getInstance().getConnection();
                    cartaoDAO.inserir(connAdd, novo);
                    connAdd.close();

                    resp.sendRedirect(req.getContextPath() + "/cartao?action=listar");
                    break;

                case "excluir":
                    int id = Integer.parseInt(req.getParameter("id"));
                    Connection connDel = ConexaoSQL.getInstance().getConnection();
                    cartaoDAO.excluir(connDel, id);
                    connDel.close();

                    resp.sendRedirect(req.getContextPath() + "/cartao?action=listar");
                    break;

                default:
                    resp.sendRedirect(req.getContextPath() + "/cartao?action=listar");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar cartão.");
        }
    }
}