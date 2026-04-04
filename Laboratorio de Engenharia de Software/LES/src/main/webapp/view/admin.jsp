<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin – Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/admin.css">
</head>
<body>

<header class="topbar">
    <h1>Painel Administrativo</h1>
    <div>
        <a href="${pageContext.request.contextPath}/view/index.jsp">Ver Loja</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </div>
</header>

<div class="layout">
    <aside class="sidebar">
        <h2>Admin</h2>
        <nav>
            <a href="${pageContext.request.contextPath}/admin" class="active">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/pedidos">Pedidos</a>
            <a href="${pageContext.request.contextPath}/view/admin-livros.html">Livros</a>
            <a href="${pageContext.request.contextPath}/view/admin-clientes.jsp">Clientes</a>
            <a href="${pageContext.request.contextPath}/view/admin-devolucoes.html">Devoluções</a>
            <a href="${pageContext.request.contextPath}/view/admin-relatorios.html">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <div class="dashboard">
            <div class="card">
                <h3>Total de Pedidos</h3>
                <p>${pedidos.size()}</p>
            </div>
            <div class="card">
                <h3>Em Processamento</h3>
                <p>
                    <c:set var="emProcessamento" value="0"/>
                    <c:forEach var="p" items="${pedidos}">
                        <c:if test="${p.status == 'EM_PROCESSAMENTO' or p.status == 'SEPARANDO'}">
                            <c:set var="emProcessamento" value="${emProcessamento + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${emProcessamento}
                </p>
            </div>
            <div class="card">
                <h3>Faturamento Total</h3>
                <p>
                    <c:set var="faturamento" value="0"/>
                    <c:forEach var="p" items="${pedidos}">
                        <c:set var="faturamento" value="${faturamento + p.total}"/>
                    </c:forEach>
                    R$ <fmt:formatNumber value="${faturamento}" minFractionDigits="2" maxFractionDigits="2"/>
                </p>
            </div>
        </div>

        <h2>Últimos Pedidos</h2>

        <table>
            <thead>
            <tr>
                <th>Pedido</th>
                <th>Cliente</th>
                <th>Data</th>
                <th>Valor Total</th>
                <th>Status</th>
                <th>Ação</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="p" items="${pedidos}" end="9">
                <tr>
                    <td>#<fmt:formatNumber value="${p.id}" minIntegerDigits="4"/></td>
                    <td>${not empty p.cliente ? p.cliente.nome : '—'}</td>
                    <td><fmt:formatDate value="${p.dataCriacao}" pattern="dd/MM/yyyy"/></td>
                    <td>R$ <fmt:formatNumber value="${p.total}" minFractionDigits="2" maxFractionDigits="2"/></td>
                    <td>${p.status}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin/pedidos?id=${p.id}" class="btn-link">Ver Pedido</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </main>
</div>

<footer>Área Administrativa – Livraria © 2026</footer>
</body>
</html>
