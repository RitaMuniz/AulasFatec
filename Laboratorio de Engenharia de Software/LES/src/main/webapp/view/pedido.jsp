<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Pedido #${pedido.id} – Livraria</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
</head>
<body>

<header>
    <h1>Livraria</h1>
    <div>
        <a href="${pageContext.request.contextPath}/view/index.jsp">Início</a>
        <a href="${pageContext.request.contextPath}/livros">Livros</a>
        <a href="${pageContext.request.contextPath}/pedidos">Meus Pedidos</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </div>
</header>

<div class="container">

    <h2>Pedido #<fmt:formatNumber value="${pedido.id}" minIntegerDigits="4"/></h2>

    <%-- Barra de status --%>
    <div class="status-bar">
        <div class="step ${pedido.status == 'EM_PROCESSAMENTO' or pedido.status == 'CONFIRMADO' or pedido.status == 'SEPARANDO' or pedido.status == 'ENVIADO' or pedido.status == 'ENTREGUE' ? '' : 'inactive'}">
            <div class="circle"></div>
            Confirmado
        </div>
        <div class="step ${pedido.status == 'SEPARANDO' or pedido.status == 'ENVIADO' or pedido.status == 'ENTREGUE' ? '' : 'inactive'}">
            <div class="circle"></div>
            Separando
        </div>
        <div class="step ${pedido.status == 'ENVIADO' or pedido.status == 'ENTREGUE' ? '' : 'inactive'}">
            <div class="circle"></div>
            Enviado
        </div>
        <div class="step ${pedido.status == 'ENTREGUE' ? '' : 'inactive'}">
            <div class="circle"></div>
            Entregue
        </div>
    </div>

    <%-- Itens --%>
    <div class="pedidos-card">
        <h3>Itens do Pedido</h3>
        <c:forEach var="item" items="${itens}">
            <div style="display:flex; justify-content:space-between; padding:8px 0; border-bottom:1px solid #eee;">
                <div>
                    <strong>${item.livro.titulo}</strong><br>
                    <small>${item.livro.autor}</small>
                </div>
                <div style="text-align:right;">
                    <span>Qtd: ${item.quantidade}</span><br>
                    <span>R$ <fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></span>
                </div>
            </div>
        </c:forEach>

        <div style="text-align:right; margin-top:15px;">
            <p>Total do Pedido: <strong>R$ <fmt:formatNumber value="${pedido.total}" minFractionDigits="2" maxFractionDigits="2"/></strong></p>
        </div>
    </div>

    <%-- Troca por item --%>
    <div class="pedidos-card">
        <h3>Solicitar Troca</h3>
        <c:choose>
            <c:when test="${pedido.status == 'ENTREGUE'}">
                <p style="font-size:13px; color:#555; margin-bottom:12px;">
                    Selecione o item que deseja trocar. Um cupom de troca com o valor do item
                    será gerado assim que a devolução for concluída pela loja.
                </p>
                <c:forEach var="item" items="${itens}">
                    <div style="display:flex; justify-content:space-between; align-items:center;
                                padding:10px 0; border-bottom:1px solid #eee;">
                        <div>
                            <strong>${item.livro.titulo}</strong><br>
                            <small>Qtd: ${item.quantidade} —
                                R$ <fmt:formatNumber value="${item.subtotal}"
                                    minFractionDigits="2" maxFractionDigits="2"/>
                            </small>
                        </div>
                        <div>
                            <c:choose>
                                <%-- Item já em processo de troca --%>
                                <c:when test="${not empty item.statusTroca}">
                                    <span style="font-size:12px; font-weight:bold; color:#e65100;">
                                        ${item.statusTroca}
                                    </span>
                                </c:when>
                                <%-- Item disponível para troca --%>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/troca?action=solicitar&pedidoId=${pedido.id}&itemPedidoId=${item.id}"
                                       class="btn"
                                       style="font-size:13px; padding:6px 14px;">
                                        Solicitar Troca
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p style="color:#888;">A solicitação de troca estará disponível após a entrega do pedido.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <a href="${pageContext.request.contextPath}/pedidos" class="btn" style="margin-top:20px; display:inline-block;">
        ← Voltar aos Pedidos
    </a>

</div>

<footer>© 2026 Livraria</footer>
</body>
</html>
