<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${livro.titulo} – Livraria</title>
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
            <c:when test="${not empty sessionScope.clienteLogado}">
                <a href="${pageContext.request.contextPath}/view/cliente.jsp">${sessionScope.cliente.nome}</a>
                <a href="${pageContext.request.contextPath}/logout">Sair</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/view/login.jsp">Login</a>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/carrinho">
            Carrinho
            <c:if test="${not empty sessionScope.carrinho and sessionScope.carrinho.totalItens > 0}">
                (${sessionScope.carrinho.totalItens})
            </c:if>
        </a>
    </div>
</header>

<div class="container">

    <c:if test="${empty livro}">
        <p>Livro não encontrado. <a href="${pageContext.request.contextPath}/livros">Voltar ao catálogo</a></p>
    </c:if>

    <c:if test="${not empty livro}">
        <div class="grid" style="align-items:start; gap:50px;">

            <div>
                <h2>${livro.titulo}</h2>
                <p><strong>Autor:</strong> ${livro.autor}</p>
                <p><strong>Editora:</strong> ${livro.editora}</p>
                <c:if test="${not empty livro.isbn}">
                    <p><strong>ISBN:</strong> ${livro.isbn}</p>
                </c:if>
                <c:if test="${not empty livro.ano}">
                    <p><strong>Ano:</strong> ${livro.ano}</p>
                </c:if>
                <c:if test="${not empty livro.numeroPaginas}">
                    <p><strong>Páginas:</strong> ${livro.numeroPaginas}</p>
                </c:if>

                <c:choose>
                    <c:when test="${livro.estoque > 0}">
                        <p style="color:green;"><strong>Disponível:</strong> ${livro.estoque} unidades</p>
                    </c:when>
                    <c:otherwise>
                        <p style="color:red;"><strong>Produto indisponível</strong></p>
                    </c:otherwise>
                </c:choose>

                <c:if test="${not empty livro.precoVenda}">
                    <p class="preco">R$ <fmt:formatNumber value="${livro.precoVenda}" minFractionDigits="2" maxFractionDigits="2"/></p>
                </c:if>

                <c:if test="${not empty livro.sinopse}">
                    <p style="margin-top:15px;">${livro.sinopse}</p>
                </c:if>

                <c:if test="${livro.estoque > 0}">
                    <form action="${pageContext.request.contextPath}/carrinho" method="post" style="margin-top:20px;">
                        <input type="hidden" name="livroId" value="${livro.id}">
                        <button type="submit" class="btn">Adicionar ao Carrinho</button>
                    </form>
                </c:if>

                <a href="${pageContext.request.contextPath}/livros" class="btn" style="margin-top:10px; display:inline-block;">Voltar</a>
            </div>

        </div>
    </c:if>

</div>

<footer>© 2026 Livraria</footer>
</body>
</html>
