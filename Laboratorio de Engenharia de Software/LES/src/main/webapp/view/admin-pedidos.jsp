<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin – Pedidos</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/admin.css">
</head>
<body>

<header class="topbar">
    <h1>Gerenciar Pedidos</h1>
    <div>
        <a href="${pageContext.request.contextPath}/view/index.jsp">Ver Loja</a>
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
            <a href="${pageContext.request.contextPath}/troca?action=admin">Devoluções</a>
            <a href="${pageContext.request.contextPath}/view/admin-relatorios.html">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <h2>Pesquisar Pedido</h2>
        <form action="${pageContext.request.contextPath}/admin/pedidos" method="get">
            <div class="form-grid">
                <div>
                    <label>Buscar por número ou cliente</label>
                    <input type="text" name="busca" placeholder="Ex: 1 ou Maria Silva"
                           value="${not empty busca ? busca : ''}">
                </div>
            </div>
            <div class="form-actions">
                <button type="submit">Pesquisar</button>
                <a href="${pageContext.request.contextPath}/admin/pedidos" class="btn-cancelar">Limpar</a>
            </div>
        </form>

        <h2>Lista de Pedidos</h2>

        <c:if test="${empty pedidos}">
            <p>Nenhum pedido encontrado.</p>
        </c:if>

        <c:if test="${not empty pedidos}">
            <table>
                <thead>
                <tr>
                    <th>Pedido</th>
                    <th>Cliente</th>
                    <th>Data</th>
                    <th>Valor Total</th>
                    <th>Status</th>
                    <th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="p" items="${pedidos}">
                    <tr>
                        <td>#<fmt:formatNumber value="${p.id}" minIntegerDigits="4"/></td>
                        <td>${not empty p.cliente ? p.cliente.nome : '—'}</td>
                        <td><fmt:formatDate value="${p.dataCriacao}" pattern="dd/MM/yyyy"/></td>
                        <td>R$ <fmt:formatNumber value="${p.total}" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td>${p.status}</td>
                        <td class="acoes">
                            <a href="${pageContext.request.contextPath}/admin/pedidos?id=${p.id}" class="btn-visualizar">Visualizar</a>
                            <a href="${pageContext.request.contextPath}/admin/pedidos?id=${p.id}&acao=editar" class="btn-editar">Editar</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>

    </main>
</div>

<footer>Área Administrativa – Livraria © 2026</footer>
</body>
</html>
