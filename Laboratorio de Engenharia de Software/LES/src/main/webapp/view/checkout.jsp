<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout – Livraria</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
    <style>
        .checkout-grid { display:grid; grid-template-columns:2fr 1fr; gap:30px; align-items:start; }
        .secao { background:#fff; border:1px solid #e0d6c8; border-radius:8px; padding:25px; margin-bottom:20px; }
        .secao h3 { margin-bottom:15px; font-size:18px; border-bottom:1px solid #eee; padding-bottom:10px; }
        .campo { margin-bottom:15px; }
        .campo label { display:block; margin-bottom:5px; font-weight:bold; font-size:14px; }
        .campo select, .campo input { width:100%; padding:10px; border:1px solid #ccc; border-radius:4px; font-size:14px; box-sizing:border-box; }
        .cartao-bloco { border:1px solid #ddd; border-radius:6px; padding:15px; margin-bottom:10px; }
        .cartao-bloco.opcional { background:#fafafa; }
        #bloco-cartao2 { display:none; }
        .resumo-linha { display:flex; justify-content:space-between; padding:6px 0; font-size:15px; }
        .resumo-linha.total { font-weight:bold; font-size:17px; border-top:2px solid #333; margin-top:8px; padding-top:10px; }
        .btn-finalizar { width:100%; padding:14px; font-size:16px; margin-top:15px; }
        .aviso { background:#fff3cd; border:1px solid #ffc107; border-radius:4px; padding:10px; font-size:13px; margin-top:8px; }
    </style>
</head>
<body>

<header>
    <h1>Livraria</h1>
    <div>
        <a href="${pageContext.request.contextPath}/view/index.jsp">Início</a>
        <a href="${pageContext.request.contextPath}/livros">Livros</a>
        <a href="${pageContext.request.contextPath}/view/cliente.jsp">${sessionScope.cliente.nome}</a>
        <a href="${pageContext.request.contextPath}/carrinho">Carrinho</a>
    </div>
</header>

<div class="container">
    <h2 style="margin-bottom:30px;">Finalizar Compra</h2>

    <form action="${pageContext.request.contextPath}/pedido" method="post" id="formCheckout">
    <div class="checkout-grid">

        <%-- ==================== COLUNA ESQUERDA ==================== --%>
        <div>

            <%-- ENDEREÇO --%>
            <div class="secao">
                <h3>Endereço de Entrega</h3>
                <c:choose>
                    <c:when test="${empty enderecos}">
                        <p>Você não tem endereços cadastrados.
                           <a href="${pageContext.request.contextPath}/view/enderecos.jsp">Cadastrar endereço</a>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <div class="campo">
                            <label>Selecione o endereço:</label>
                            <select name="endereco_id" required>
                                <c:forEach var="e" items="${enderecos}">
                                    <option value="${e.id}">
                                        ${e.tipoLogradouro} ${e.logradouro}, ${e.numero} – ${e.bairro} – CEP ${e.cep}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="campo">
                    <label>Frete:</label>
                    <p><strong>R$ 20,00</strong> – Entrega padrão (até 7 dias úteis)</p>
                </div>
            </div>

            <%-- PAGAMENTO CARTÃO 1 --%>
            <div class="secao">
                <h3>Forma de Pagamento</h3>

                <c:if test="${empty cartoes}">
                    <p>Você não tem cartões cadastrados.
                       <a href="${pageContext.request.contextPath}/cartao?action=listar">Cadastrar cartão</a>
                    </p>
                </c:if>

                <c:if test="${not empty cartoes}">
                    <div class="cartao-bloco">
                        <p style="font-weight:bold; margin-bottom:10px;">Cartão 1 (obrigatório)</p>
                        <div class="campo">
                            <label>Cartão:</label>
                            <select name="cartao1_id" id="cartao1_id" required onchange="atualizarResumo()">
                                <c:forEach var="c" items="${cartoes}">
                                    <option value="${c.id}">
                                        **** **** **** ${c.numero.length() > 4 ? c.numero.substring(c.numero.length()-4) : c.numero}
                                        – ${c.nomeImpresso}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="campo">
                            <label>Valor a pagar neste cartão (R$):</label>
                            <input type="number" name="valor_cartao1" id="valor_cartao1"
                                   step="0.01" min="0.01"
                                   placeholder="Ex: 50.00"
                                   required
                                   onchange="atualizarResumo()">
                        </div>
                    </div>

                    <%-- CARTÃO 2 --%>
                    <div style="margin-bottom:10px;">
                        <label>
                            <input type="checkbox" id="ativarCartao2" onchange="toggleCartao2()">
                            Usar um segundo cartão
                        </label>
                    </div>

                    <div class="cartao-bloco opcional" id="bloco-cartao2">
                        <p style="font-weight:bold; margin-bottom:10px;">Cartão 2 (opcional)</p>
                        <div class="campo">
                            <label>Cartão:</label>
                            <select name="cartao2_id" id="cartao2_id" onchange="atualizarResumo()">
                                <option value="">— Selecione —</option>
                                <c:forEach var="c" items="${cartoes}">
                                    <option value="${c.id}">
                                        **** **** **** ${c.numero.length() > 4 ? c.numero.substring(c.numero.length()-4) : c.numero}
                                        – ${c.nomeImpresso}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="campo">
                            <label>Valor a pagar neste cartão (R$):</label>
                            <input type="number" name="valor_cartao2" id="valor_cartao2"
                                   step="0.01" min="0"
                                   placeholder="Ex: 30.00"
                                   onchange="atualizarResumo()">
                        </div>
                    </div>

                    <div id="aviso-valor" class="aviso" style="display:none;">
                        ⚠️ A soma dos cartões deve ser igual ao total do pedido.
                    </div>
                </c:if>
            </div>

            <%-- CUPOM --%>
            <div class="secao">
                <h3>Cupom de Desconto</h3>
                <c:choose>
                    <c:when test="${empty cupons}">
                        <p>Você não possui cupons disponíveis.</p>
                        <input type="hidden" name="cupom_id" value="">
                    </c:when>
                    <c:otherwise>
                        <div class="campo">
                            <label>Selecione um cupom:</label>
                            <select name="cupom_id" id="cupom_id" onchange="atualizarResumo()">
                                <option value="">— Nenhum cupom —</option>
                                <c:forEach var="cup" items="${cupons}">
                                    <option value="${cup.id}" data-valor="${cup.valor}">
                                        ${cup.codigo} – R$ <fmt:formatNumber value="${cup.valor}" minFractionDigits="2" maxFractionDigits="2"/> de desconto
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <%-- ==================== COLUNA DIREITA – RESUMO ==================== --%>
        <div class="secao">
            <h3>Resumo do Pedido</h3>

            <c:forEach var="item" items="${sessionScope.carrinho.itens}">
                <div class="resumo-linha">
                    <span>${item.livro.titulo} x${item.quantidade}</span>
                    <span>R$ <fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
            </c:forEach>

            <div class="resumo-linha">
                <span>Subtotal</span>
                <span id="r-subtotal">R$ <fmt:formatNumber value="${sessionScope.carrinho.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span>
            </div>
            <div class="resumo-linha">
                <span>Frete</span>
                <span>R$ 20,00</span>
            </div>
            <div class="resumo-linha">
                <span>Desconto (cupom)</span>
                <span id="r-desconto">R$ 0,00</span>
            </div>
            <div class="resumo-linha total">
                <span>Total</span>
                <span id="r-total">R$ <fmt:formatNumber value="${sessionScope.carrinho.subtotal + 20}" minFractionDigits="2" maxFractionDigits="2"/></span>
            </div>

            <button type="submit" class="btn btn-finalizar"
                    <c:if test="${empty cartoes or empty enderecos}">disabled title="Cadastre endereço e cartão para continuar"</c:if>>
                Confirmar Pedido
            </button>

            <a href="${pageContext.request.contextPath}/carrinho" class="btn"
               style="width:100%; text-align:center; margin-top:10px; display:block; box-sizing:border-box; background:#888;">
                Voltar ao Carrinho
            </a>
        </div>

    </div>
    </form>
</div>

<footer>© 2026 Livraria</footer>

<script>
    // valores vindos do JSP para o JS
    const subtotal = parseFloat("${sessionScope.carrinho.subtotal}") || 0;
    const frete = 20.00;

    function fmt(val) {
        return "R$ " + val.toFixed(2).replace(".", ",");
    }

    function atualizarResumo() {
        // desconto pelo cupom selecionado
        const cupomSel = document.getElementById("cupom_id");
        let desconto = 0;
        if (cupomSel) {
            const opt = cupomSel.options[cupomSel.selectedIndex];
            desconto = parseFloat(opt.getAttribute("data-valor") || "0") || 0;
        }

        const total = Math.max(0, subtotal + frete - desconto);

        document.getElementById("r-desconto").textContent = fmt(desconto);
        document.getElementById("r-total").textContent = fmt(total);

        // validar soma dos cartões
        const v1 = parseFloat(document.getElementById("valor_cartao1")?.value || "0") || 0;
        const ativo2 = document.getElementById("ativarCartao2")?.checked;
        const v2 = ativo2 ? (parseFloat(document.getElementById("valor_cartao2")?.value || "0") || 0) : 0;
        const soma = v1 + v2;

        const aviso = document.getElementById("aviso-valor");
        if (aviso && soma > 0) {
            // tolerância de R$ 0,01 por arredondamento
            if (Math.abs(soma - total) > 0.02) {
                aviso.style.display = "block";
                aviso.textContent = "⚠️ A soma dos valores nos cartões (R$ " + soma.toFixed(2).replace(".",",") +
                    ") deve ser igual ao total do pedido (" + fmt(total) + ").";
            } else {
                aviso.style.display = "none";
            }
        } else if (aviso) {
            aviso.style.display = "none";
        }
    }

    function toggleCartao2() {
        const bloco = document.getElementById("bloco-cartao2");
        const ativo = document.getElementById("ativarCartao2").checked;
        bloco.style.display = ativo ? "block" : "none";
        if (!ativo) {
            document.getElementById("valor_cartao2").value = "";
            document.getElementById("cartao2_id").value = "";
        }
        atualizarResumo();
    }

    // pré-preenche o valor do cartão 1 com o total ao carregar
    document.addEventListener("DOMContentLoaded", function() {
        atualizarResumo();
        const v1 = document.getElementById("valor_cartao1");
        if (v1 && !v1.value) {
            const total = subtotal + frete;
            v1.value = total.toFixed(2);
        }
    });

    // validação antes de submeter
    document.getElementById("formCheckout").addEventListener("submit", function(e) {
        const cupomSel = document.getElementById("cupom_id");
        let desconto = 0;
        if (cupomSel) {
            const opt = cupomSel.options[cupomSel.selectedIndex];
            desconto = parseFloat(opt.getAttribute("data-valor") || "0") || 0;
        }
        const total = Math.max(0, subtotal + frete - desconto);
        const v1 = parseFloat(document.getElementById("valor_cartao1")?.value || "0") || 0;
        const ativo2 = document.getElementById("ativarCartao2")?.checked;
        const v2 = ativo2 ? (parseFloat(document.getElementById("valor_cartao2")?.value || "0") || 0) : 0;
        const soma = v1 + v2;

        if (Math.abs(soma - total) > 0.02) {
            e.preventDefault();
            alert("A soma dos valores nos cartões deve ser igual ao total do pedido: " + fmt(total));
        }
    });
</script>
</body>
</html>
