<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrinho – Livraria</title>
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
        <a href="${pageContext.request.contextPath}/carrinho">Carrinho</a>
    </div>
</header>

<div class="container">
    <h2>Seu Carrinho</h2>

    <c:choose>
        <c:when test="${empty sessionScope.carrinho or empty sessionScope.carrinho.itens}">
            <div class="card" style="text-align:center; padding:40px;">
                <p>Seu carrinho está vazio.</p>
                <a href="${pageContext.request.contextPath}/livros" class="btn" style="margin-top:15px;">Ver Livros</a>
            </div>
        </c:when>

        <c:otherwise>
            <table class="table" style="width:100%; border-collapse:collapse; margin-bottom:30px;">
                <thead>
                    <tr>
                        <th style="text-align:left; padding:12px; border-bottom:2px solid #ddd;">Livro</th>
                        <th style="padding:12px; border-bottom:2px solid #ddd;">Preço Unit.</th>
                        <th style="padding:12px; border-bottom:2px solid #ddd;">Qtd.</th>
                        <th style="padding:12px; border-bottom:2px solid #ddd;">Subtotal</th>
                        <th style="padding:12px; border-bottom:2px solid #ddd;">Ação</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${sessionScope.carrinho.itens}">
                        <tr>
                            <td style="padding:12px; border-bottom:1px solid #eee;">
                                <strong>${item.livro.titulo}</strong><br>
                                <small>${item.livro.autor}</small>
                            </td>
                            <td style="padding:12px; border-bottom:1px solid #eee; text-align:center;">
                                R$ <fmt:formatNumber value="${item.precoUnitario}" minFractionDigits="2" maxFractionDigits="2"/>
                            </td>
                            <td style="padding:12px; border-bottom:1px solid #eee; text-align:center;">
                                <form action="${pageContext.request.contextPath}/carrinho" method="post"
                                      style="display:flex; align-items:center; justify-content:center; gap:6px;">
                                    <input type="hidden" name="livroId" value="${item.livroId}">
                                    <input type="hidden" name="acao" value="atualizar">
                                    <input type="number" name="quantidade" value="${item.quantidade}" min="1"
                                           max="${item.livro.estoque}"
                                           style="width:60px; padding:6px; border:1px solid #ccc; border-radius:4px; text-align:center;">
                                    <button type="submit" class="btn" style="font-size:12px; padding:6px 10px;">✓</button>
                                </form>
                            </td>
                            <td style="padding:12px; border-bottom:1px solid #eee; text-align:center;">
                                R$ <fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/>
                            </td>
                            <td style="padding:12px; border-bottom:1px solid #eee; text-align:center;">
                                <a href="${pageContext.request.contextPath}/carrinho?acao=remover&livroId=${item.livroId}"
                                   class="btn"
                                   style="background:#c0392b; font-size:13px; padding:6px 12px;"
                                   onclick="return confirm('Remover este item?')">
                                    Remover
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="card" style="text-align:right; max-width:350px; margin-left:auto;">
                <p>Subtotal: <strong>R$ <fmt:formatNumber value="${sessionScope.carrinho.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></strong></p>
                <p>Frete: <strong>R$ 20,00</strong></p>
                <hr style="margin:10px 0;">
                <p style="font-size:18px;">Total estimado: <strong>R$ <fmt:formatNumber value="${sessionScope.carrinho.subtotal + 20}" minFractionDigits="2" maxFractionDigits="2"/></strong></p>
                <small style="color:#888;">(desconto e cupom aplicados no checkout)</small>
            </div>

            <div style="display:flex; justify-content:space-between; margin-top:30px;">
                <a href="${pageContext.request.contextPath}/livros" class="btn">Continuar Comprando</a>

                <c:choose>
                    <c:when test="${not empty sessionScope.clienteLogado}">
                        <a href="${pageContext.request.contextPath}/pedido" class="btn">Finalizar Compra</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/view/login.jsp" class="btn">Login para Finalizar</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer>© 2026 Livraria</footer>
</body>
</html>
