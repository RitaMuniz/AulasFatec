<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livros – Livraria</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
</head>
<body>

<header>
    <h1>Livraria</h1>
    <div>
        <a href="${pageContext.request.contextPath}/view/index.jsp">Início</a>
        <a href="${pageContext.request.contextPath}/livros">Livros</a>
        <c:choose>
            <c:when test="${not empty sessionScope.cliente}">
                <a href="${pageContext.request.contextPath}/view/cliente.jsp">${sessionScope.cliente.nome}</a>
                <a href="${pageContext.request.contextPath}/logout">Sair</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/view/login.jsp">Login</a>
            </c:otherwise>
        </c:choose>
        <a data-test="icon-carrinho" href="${pageContext.request.contextPath}/carrinho">
            Carrinho
            <c:if test="${not empty sessionScope.carrinho and sessionScope.carrinho.totalItens > 0}">
                (${sessionScope.carrinho.totalItens})
            </c:if>
        </a>
    </div>
</header>

<div class="container">
    <h2>Catálogo</h2>

    <c:if test="${empty livros}">
        <p>Nenhum livro disponível no momento.</p>
    </c:if>

    <div class="grid">
        <c:forEach var="l" items="${livros}">
            <div class="card">
                <c:if test="${not empty l.imagemUrl}">
                    <img src="${l.imagemUrl}" alt="${l.titulo}" style="width:100%; height:200px; object-fit:cover; border-radius:4px; margin-bottom:10px;">
                </c:if>
                <h3>${l.titulo}</h3>
                <p><strong>Autor:</strong> ${l.autor}</p>
                <p><strong>Editora:</strong> ${l.editora}</p>
                <c:if test="${l.estoque > 0}">
                    <p style="color:green;"><strong>Disponível:</strong> ${l.estoque} un.</p>
                </c:if>
                <c:if test="${l.estoque <= 0}">
                    <p style="color:red;"><strong>Indisponível</strong></p>
                </c:if>
                <c:if test="${not empty l.precoVenda}">
                    <p class="preco">R$ <fmt:formatNumber value="${l.precoVenda}" minFractionDigits="2" maxFractionDigits="2"/></p>
                </c:if>
                <a href="${pageContext.request.contextPath}/livro?id=${l.id}" class="btn" data-test="btn-ver-detalhes-${l.id}">Ver Detalhes</a>
            </div>
        </c:forEach>
    </div>
</div>

<footer>© 2026 Livraria</footer>
</body>
</html>
