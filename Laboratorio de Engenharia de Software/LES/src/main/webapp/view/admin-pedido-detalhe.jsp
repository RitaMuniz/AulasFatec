<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin – Detalhe do Pedido</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/admin.css">
</head>
<body>

<header class="topbar">
    <h1>Detalhe do Pedido #<fmt:formatNumber value="${pedido.id}" minIntegerDigits="4"/></h1>
    <div>
        <a href="${pageContext.request.contextPath}/admin/pedidos">Voltar</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </div>
</header>

<div class="layout">
    <aside class="sidebar">
        <h2>Admin</h2>
        <nav>
            <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/pedidos" class="active">Pedidos</a>
            <a href="${pageContext.request.contextPath}/view/admin-livros.html">Livros</a>
            <a href="${pageContext.request.contextPath}/view/admin-clientes.jsp">Clientes</a>
            <a href="${pageContext.request.contextPath}/view/admin-devolucoes.html">Devoluções</a>
            <a href="${pageContext.request.contextPath}/view/admin-relatorios.html">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <h2>Informações do Pedido</h2>
        <table>
            <tr><th>Número</th><td>#<fmt:formatNumber value="${pedido.id}" minIntegerDigits="4"/></td></tr>
            <tr><th>Data</th><td><fmt:formatDate value="${pedido.dataCriacao}" pattern="dd/MM/yyyy HH:mm"/></td></tr>
            <tr><th>Status</th><td>${pedido.status}</td></tr>
        </table>

        <br>

        <h2>Informações do Cliente</h2>
        <table>
            <tr><th>Nome</th><td>${pedido.cliente.nome}</td></tr>
            <tr><th>Email</th><td>${pedido.cliente.email}</td></tr>
            <tr><th>CPF</th><td>${pedido.cliente.cpf}</td></tr>
        </table>

        <br>

        <h2>Itens do Pedido</h2>
        <table>
            <thead>
            <tr>
                <th>Livro</th>
                <th>Autor</th>
                <th>Quantidade</th>
                <th>Preço Unitário</th>
                <th>Subtotal</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${pedido.itens}">
                <tr>
                    <td>${item.livro.titulo}</td>
                    <td>${item.livro.autor}</td>
                    <td>${item.quantidade}</td>
                    <td>R$ <fmt:formatNumber value="${item.precoUnitario}" minFractionDigits="2" maxFractionDigits="2"/></td>
                    <td>R$ <fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <br>

        <h2>Resumo Financeiro</h2>
        <table>
            <tr><th>Valor Total</th><td><strong>R$ <fmt:formatNumber value="${pedido.total}" minFractionDigits="2" maxFractionDigits="2"/></strong></td></tr>
        </table>

        <br>

        <div class="form-actions">
            <a href="${pageContext.request.contextPath}/admin/pedidos?id=${pedido.id}&acao=editar" class="btn-editar">Editar Pedido</a>
            <a href="${pageContext.request.contextPath}/admin/pedidos" class="btn-cancelar">Voltar</a>
        </div>

    </main>
</div>

<footer>Área Administrativa – Livraria © 2026</footer>
</body>
</html>
