<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Meus Pedidos – Livraria</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
</head>
<body>

<header>
    <h1>Livraria</h1>
    <div>
        <a href="${pageContext.request.contextPath}/view/index.jsp">Início</a>
        <a href="${pageContext.request.contextPath}/livros">Livros</a>
        <a href="${pageContext.request.contextPath}/carrinho">Carrinho</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </div>
</header>

<div class="container">
    <h2>Meus Pedidos</h2>

    <c:if test="${empty pedidos}">
        <div class="card" style="text-align:center; padding:40px;">
            <p>Você ainda não realizou nenhum pedido.</p>
            <a href="${pageContext.request.contextPath}/livros" class="btn" style="margin-top:15px;">Ver Livros</a>
        </div>
    </c:if>

    <c:forEach var="p" items="${pedidos}">
        <div class="pedido-card">
            <div>
                <p data-test="pedido-numero-${p.id}"><strong>Pedido #<fmt:formatNumber value="${p.id}" minIntegerDigits="4"/></strong></p>
                <p>Data: <fmt:formatDate value="${p.dataCriacao}" pattern="dd/MM/yyyy"/></p>
                <p data-test="pedido-total-${p.id}">Total: <strong>R$ <fmt:formatNumber value="${p.total}" minFractionDigits="2" maxFractionDigits="2"/></strong></p>
                <p class="status" data-test="pedido-status-${p.id}">Status: ${p.status}</p>
            </div>
            <button data-test="botao-detalhes-pedido-${p.id}"
                    onclick="window.location.href='${pageContext.request.contextPath}/pedidos?id=${p.id}'">
                Ver Detalhes
            </button>
        </div>
    </c:forEach>
</div>

<footer>© 2026 Livraria</footer>
</body>
</html>
