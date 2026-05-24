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
<style>
        .filtros-container {
            margin: 20px 0 28px;
        }
        .filtros-form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }
        .busca-wrapper {
            position: relative;
            flex: 1 1 260px;
        }
        .busca-wrapper input[type="text"] {
            width: 100%;
            padding: 10px 40px 10px 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 0.95rem;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }
        .busca-wrapper input[type="text"]:focus {
            outline: none;
            border-color: #5a7a6a;
        }
        .busca-wrapper .icone-busca {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            pointer-events: none;
        }
        .filtros-form select {
            padding: 10px 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 0.95rem;
            background: #fff;
            cursor: pointer;
            flex: 0 1 220px;
            transition: border-color 0.2s;
        }
        .filtros-form select:focus {
            outline: none;
            border-color: #5a7a6a;
        }
        .btn-buscar {
            padding: 10px 22px;
            background-color: #5a7a6a;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 0.95rem;
            cursor: pointer;
            white-space: nowrap;
            transition: background-color 0.2s;
        }
        .btn-buscar:hover { background-color: #4a6a5a; }
        .btn-limpar {
            padding: 10px 16px;
            background: transparent;
            color: #666;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 0.9rem;
            cursor: pointer;
            text-decoration: none;
            white-space: nowrap;
        }
        .btn-limpar:hover { background-color: #f0f0f0; }
        .resultado-info {
            font-size: 0.9rem;
            color: #555;
            margin-bottom: 16px;
        }
        .tag-categoria {
            display: inline-block;
            background: #eef3f0;
            color: #4a6a5a;
            border-radius: 4px;
            padding: 2px 8px;
            font-size: 0.8rem;
            margin: 2px 2px 6px 0;
        }
        .vazio {
            text-align: center;
            padding: 48px 0;
            color: #777;
        }
        .vazio p { font-size: 1.05rem; margin-bottom: 12px; }
</style>
<body>

<header>
    <h1>Livraria</h1>
    <div>
        <a href="${pageContext.request.contextPath}/home">Início</a>
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

    <%-- ── Barra de pesquisa e filtro ── --%>
    <div class="filtros-container">
        <form class="filtros-form" method="get" action="${pageContext.request.contextPath}/livros">

            <div class="busca-wrapper">
                <input type="text"
                       name="busca"
                       placeholder="Buscar por título ou autor..."
                       value="${buscaAtual}"
                       data-test="input-busca" />
                <span class="icone-busca">&#128269;</span>
            </div>

            <select name="categoriaId" data-test="select-categoria">
                <option value="">Todas as categorias</option>
                <c:forEach var="cat" items="${categorias}">
                    <option value="${cat.id}"
                        <c:if test="${cat.id == categoriaIdAtual}">selected</c:if>>
                        ${cat.nome}
                    </option>
                </c:forEach>
            </select>

            <button type="submit" class="btn-buscar" data-test="btn-buscar">Buscar</button>

            <c:if test="${not empty buscaAtual or not empty categoriaIdAtual}">
                <a href="${pageContext.request.contextPath}/livros" class="btn-limpar" data-test="btn-limpar">
                    ✕ Limpar filtros
                </a>
            </c:if>
        </form>
    </div>

    <%-- ── Info de resultado ── --%>
    <c:if test="${not empty buscaAtual or not empty categoriaIdAtual}">
        <p class="resultado-info">
            <c:choose>
                <c:when test="${empty livros}">Nenhum resultado encontrado</c:when>
                <c:otherwise><strong>${livros.size()}</strong> livro(s) encontrado(s)</c:otherwise>
            </c:choose>
            <c:if test="${not empty buscaAtual}">
                para "<strong>${buscaAtual}</strong>"
            </c:if>
        </p>
    </c:if>

    <%-- ── Grid de livros ── --%>
    <c:choose>
        <c:when test="${empty livros}">
            <div class="vazio">
                <p>Nenhum livro encontrado com os filtros selecionados.</p>
                <a href="${pageContext.request.contextPath}/livros" class="btn-limpar">Ver todos os livros</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="grid">
                <c:forEach var="l" items="${livros}">
                    <div class="card">
                        <c:if test="${not empty l.imagemUrl}">
                            <img src="${l.imagemUrl}" alt="${l.titulo}"
                                 style="width:100%; height:200px; object-fit:cover; border-radius:4px; margin-bottom:10px;">
                        </c:if>
                        <h3>${l.titulo}</h3>
                        <p><strong>Autor:</strong> ${l.autor}</p>
                        <p><strong>Editora:</strong> ${l.editora}</p>

                        <%-- Categorias como tags --%>
                        <c:if test="${not empty l.categorias}">
                            <div>
                                <c:forEach var="cat" items="${l.categorias}">
                                    <span class="tag-categoria">${cat.nome}</span>
                                </c:forEach>
                            </div>
                        </c:if>

                        <c:choose>
                            <c:when test="${l.estoque > 0}">
                                <p style="color:green;"><strong>Disponível:</strong> ${l.estoque} un.</p>
                            </c:when>
                            <c:otherwise>
                                <p style="color:red;"><strong>Indisponível</strong></p>
                            </c:otherwise>
                        </c:choose>

                        <c:if test="${not empty l.precoVenda}">
                            <p class="preco">R$ <fmt:formatNumber value="${l.precoVenda}" minFractionDigits="2" maxFractionDigits="2"/></p>
                        </c:if>

                        <a href="${pageContext.request.contextPath}/livro?id=${l.id}" class="btn"
                           data-test="btn-ver-detalhes-${l.id}">Ver Detalhes</a>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer>© 2026 Livraria</footer>
<%@ include file="chatbot-widget.jsp" %>
</body>
</html>
