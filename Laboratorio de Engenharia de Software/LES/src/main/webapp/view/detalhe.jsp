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

    <c:if test="${empty livro}">
        <p>Livro não encontrado. <a href="${pageContext.request.contextPath}/livros">Voltar ao catálogo</a></p>
    </c:if>

    <c:if test="${not empty livro}">
        <div class="grid" style="align-items:start; gap:50px;">

            <div>
                <c:if test="${not empty livro.imagemUrl}">
                    <img src="${livro.imagemUrl}" alt="${livro.titulo}" style="width:100%; max-width:280px; border-radius:6px; box-shadow:0 2px 8px rgba(0,0,0,0.15);">
                </c:if>
            </div>

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
                        <p style="color:green;" data-test="quantidade_livros_disponivel"><strong>Disponível:</strong> ${livro.estoque} unidades</p>
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
                        <div style="display:flex; align-items:center; gap:10px; margin-bottom:10px;" data-test="container-quantidade-${livro.id}">
                            <label><strong>Quantidade:</strong></label>
                            <input type="number" name="quantidade" value="1" min="1" max="${livro.estoque}" data-test="input-quantidade-${livro.id}"
                                   style="width:70px; padding:8px; border:1px solid #ccc; border-radius:4px;">
                            <small style="color:#888;" data-test="text-estoque-${livro.id}">máx. ${livro.estoque}</small>
                        </div>
                        <button type="submit" class="btn" data-test="adicionar_carrinho">Adicionar ao Carrinho</button>
                    </form>
                </c:if>

                <a href="${pageContext.request.contextPath}/livros" class="btn" data-test="botao_voltar" style="margin-top:10px; display:inline-block;">Voltar</a>
            </div>

        </div>
    </c:if>

</div>

<footer>© 2026 Livraria</footer>
</body>
</html>
