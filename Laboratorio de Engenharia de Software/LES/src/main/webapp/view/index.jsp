<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livraria</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
</head>
<body>

<header class="navbar">
    <div class="logo">Livraria</div>
    <nav>
        <a href="${pageContext.request.contextPath}/home">Inicio</a>
        <a href="${pageContext.request.contextPath}/livros" data-test="menu_livros">Livros</a>
        <a data-test="icon-carrinho" href="${pageContext.request.contextPath}/view/carrinho.jsp">Carrinho</a>
        <c:choose>
            <c:when test="${not empty sessionScope.clienteLogado}">
                <a href="${pageContext.request.contextPath}/cliente?action=buscar">Meu Perfil</a>
                <a href="${pageContext.request.contextPath}/logout">Sair</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/view/login.jsp">Login</a>
            </c:otherwise>
        </c:choose>
    </nav>
</header>

<section class="banner">
    <h1>Descubra histórias incríveis</h1>
    <p>Os melhores livros físicos você encontra aqui.</p>
</section>

<main class="container">

    <h2 class="section-title">Mais Vendidos</h2>
    <p class="section-subtitle">Os títulos favoritos dos nossos clientes</p>

    <div class="grid">
        <c:forEach var="l" items="${livros}">
            <div class="card">
                <span class="badge-vendido">🔥 Mais vendido</span>

                <c:if test="${not empty l.imagemUrl}">
                    <img src="${l.imagemUrl}" alt="${l.titulo}"
                         style="width:100%; height:200px; object-fit:cover; border-radius:4px; margin-bottom:10px;">
                </c:if>

                <h3>${l.titulo}</h3>
                <p><strong>Autor:</strong> ${l.autor}</p>
                <p><strong>Editora:</strong> ${l.editora}</p>

                <c:choose>
                    <c:when test="${l.estoque > 0}">
                        <p class="card-estoque-ok">✔ Em estoque</p>
                    </c:when>
                    <c:otherwise>
                        <p class="card-estoque-out">✘ Indisponível</p>
                    </c:otherwise>
                </c:choose>

                <c:if test="${not empty l.precoVenda}">
                    <p class="preco">
                        R$ <fmt:formatNumber value="${l.precoVenda}"
                               minFractionDigits="2" maxFractionDigits="2"/>
                    </p>
                </c:if>

                <a href="${pageContext.request.contextPath}/livro?id=${l.id}"
                   class="btn" data-test="btn-ver-detalhes-${l.id}">Ver Detalhes</a>
            </div>
        </c:forEach>

        <%-- Caso não haja vendas ainda --%>
        <c:if test="${empty livros}">
            <p style="color:#666;">Nenhum destaque disponível no momento.</p>
        </c:if>
    </div>

</main>

<footer>© 2026 Livraria</footer>
<%@ include file="chatbot-widget.jsp" %>
</body>
</html>