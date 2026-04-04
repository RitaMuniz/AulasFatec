package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import projetoLivraria.dao.CartaoDAO;
import projetoLivraria.dao.CupomDAO;
import projetoLivraria.dao.EnderecoDAO;
import projetoLivraria.model.*;
import projetoLivraria.service.PedidoService;
import projetoLivraria.uteis.ConexaoSQL;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.List;

public class PedidoController extends HttpServlet {

    private final EnderecoDAO enderecoDAO = new EnderecoDAO();
    private final CartaoDAO cartaoDAO = new CartaoDAO();
    private final CupomDAO cupomDAO = new CupomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");

        if (carrinho == null || carrinho.getItens().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/carrinho");
            return;
        }

        Cliente cliente = (Cliente) session.getAttribute("clienteLogado");
        if (cliente == null) {
            resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
            return;
        }

        try (Connection con = ConexaoSQL.getInstance().getConnection()) {

            List<Endereco> enderecos = enderecoDAO.listarPorCliente(con, cliente.getId());
            List<Cartao>   cartoes   = cartaoDAO.listarPorCliente(con, cliente.getId());
            List<Cupom>    cupons    = cupomDAO.listarDisponiveisPorCliente(cliente.getId());

            req.setAttribute("enderecos", enderecos);
            req.setAttribute("cartoes", cartoes);
            req.setAttribute("cupons", cupons);
            req.getRequestDispatcher("/view/checkout.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            HttpSession session = req.getSession();
            Cliente cliente = (Cliente) session.getAttribute("clienteLogado");
            Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");

            if (cliente == null || carrinho == null || carrinho.getItens().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/view/login.jsp");
                return;
            }

            int enderecoId = Integer.parseInt(req.getParameter("endereco_id"));

            int cartao1Id = Integer.parseInt(req.getParameter("cartao1_id"));
            BigDecimal valor1 = new BigDecimal(req.getParameter("valor_cartao1").replace(",", "."));

            Integer cartao2Id = null;
            BigDecimal valor2 = null;
            String cartao2Str = req.getParameter("cartao2_id");
            String valor2Str = req.getParameter("valor_cartao2");
            if (cartao2Str != null && !cartao2Str.isEmpty()) {
                cartao2Id = Integer.parseInt(cartao2Str);
                valor2 = new BigDecimal(valor2Str.replace(",", "."));
            }

            Cupom cupom = null;
            String cupomIdStr = req.getParameter("cupom_id");
            if (cupomIdStr != null && !cupomIdStr.isEmpty()) {
                cupom = cupomDAO.buscarPorId(Integer.parseInt(cupomIdStr));
            }

            // Frete fixo (fazer calculo depois)
            BigDecimal frete = new BigDecimal("20.00");

            PedidoService service = new PedidoService();
            int pedidoId = service.finalizarCompra(
                    cliente.getId(),
                    enderecoId,
                    carrinho,
                    frete,
                    cartao1Id, valor1,
                    cartao2Id, valor2,
                    cupom
            );

            session.removeAttribute("carrinho");
            session.setAttribute("pedidoId", pedidoId);

            resp.sendRedirect(req.getContextPath() + "/view/confirmacao.html");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/view/erro.jsp");
        }
    }
}