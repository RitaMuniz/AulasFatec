package projetoLivraria.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import projetoLivraria.model.*;
import projetoLivraria.service.PedidoService;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/pedido")
public class PedidoController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();

            Cliente cliente = (Cliente) session.getAttribute("cliente");
            Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");

            if (cliente == null || carrinho == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int enderecoId = Integer.parseInt(request.getParameter("endereco_id"));

            String[] cartoes = request.getParameterValues("cartao_id");
            String[] valores = request.getParameterValues("valor_cartao");

            Integer cartao1Id = null, cartao2Id = null;
            BigDecimal valor1 = null, valor2 = null;

            if (cartoes != null && cartoes.length > 0) {
                cartao1Id = Integer.parseInt(cartoes[0]);
                valor1 = new BigDecimal(valores[0]);
            }

            if (cartoes != null && cartoes.length > 1) {
                cartao2Id = Integer.parseInt(cartoes[1]);
                valor2 = new BigDecimal(valores[1]);
            }

            // cupom (opcional)
            Cupom cupom = null;
            String cupomId = request.getParameter("cupom_id");
            String valorCupom = request.getParameter("valor_cupom");

            if (cupomId != null && !cupomId.isEmpty()) {
                cupom = new Cupom();
                cupom.setId(Integer.parseInt(cupomId));
                cupom.setValor(new BigDecimal(valorCupom));
                cupom.setTipo("CUPOM PROMOCIONAL");
            }

            PedidoService service = new PedidoService();

            int pedidoId = service.finalizarCompra(
                    cliente.getId(),
                    enderecoId,
                    carrinho,
                    new BigDecimal("20.00"),
                    cartao1Id, valor1,
                    cartao2Id, valor2,
                    cupom
            );

            session.removeAttribute("carrinho");
            session.setAttribute("pedidoId", pedidoId);

            response.sendRedirect("confirmacao.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
        }
    }
}

