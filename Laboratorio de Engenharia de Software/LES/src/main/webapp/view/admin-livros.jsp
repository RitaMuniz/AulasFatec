<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin - Livros</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/admin.css">
</head>

<body>

<header class="topbar">
    <h1>Gerenciar Livros</h1>
    <h2>Obs: Página Estática, não é possível cadastramento, edição ou exclusão</h2>
    <div>
        <a href="${pageContext.request.contextPath}/home">Ver Loja</a>
        <a href="login.jsp">Sair</a>
    </div>
</header>

<div class="layout">

    <aside class="sidebar">
        <h2>Admin</h2>
        <nav>
            <a href="${pageContext.request.contextPath}/admin" data-test="button-dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/pedidos" data-test="button-pedidos">Pedidos</a>
            <a href="${pageContext.request.contextPath}/admin-livros" class="active"  data-test="button-livros">Livros</a>
            <a href="${pageContext.request.contextPath}/view/admin-clientes.jsp" data-test="button-clientes">Clientes</a>
            <a href="${pageContext.request.contextPath}/troca?action=admin" data-test="button-devolucoes">Devoluções</a>
            <a href="${pageContext.request.contextPath}/admin-relatorios" data-test="button-relatorios">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <%-- Formulário de cadastro estático (demonstração) --%>
        <h2>Cadastrar Novo Livro</h2>

        <form method="post">

            <div class="form-grid">
                <div>
                    <label>Título</label>
                    <input type="text" name="titulo" required>
                </div>

                <div>
                    <label>Autor</label>
                    <input type="text" name="autor" required>
                </div>

                <div>
                    <label>ISBN</label>
                    <input type="text" name="isbn">
                </div>

                <div>
                    <label>Categoria</label>
                    <input type="text" name="categoria">
                </div>

                <div>
                    <label>Preço (R$)</label>
                    <input type="number" name="preco" step="0.01" min="0" required>
                </div>

                <div>
                    <label>Estoque</label>
                    <input type="number" name="estoque" min="0" required>
                </div>

                <div>
                    <label>Status</label>
                    <select name="status">
                        <option selected>Ativo</option>
                        <option>Inativo</option>
                    </select>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit">Cadastrar Livro</button>
                <a href="${pageContext.request.contextPath}/admin-livros" class="btn-cancelar">Limpar</a>
            </div>

        </form>

        <%-- Tabela dinâmica --%>
        <h2>Lista de Livros</h2>

        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Título</th>
                <th>Autor</th>
                <th>Categoria</th>
                <th>Preço</th>
                <th>Estoque</th>
                <th>Status</th>
                <th>Ações</th>
            </tr>
            </thead>

            <tbody>
            <c:choose>
                <c:when test="${empty livros}">
                    <tr>
                        <td colspan="8" style="text-align:center;">Nenhum livro cadastrado.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="livro" items="${livros}">
                        <tr>
                            <td>${livro.id}</td>
                            <td>${livro.titulo}</td>
                            <td>${livro.autor}</td>

                            <%-- Exibe as categorias separadas por vírgula --%>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty livro.categorias}">
                                        <c:forEach var="cat" items="${livro.categorias}" varStatus="loop">
                                            ${cat.nome}<c:if test="${!loop.last}">, </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </td>

                            <%-- Preço de venda calculado no DAO --%>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty livro.precoVenda}">
                                        R$ <fmt:formatNumber value="${livro.precoVenda}"
                                                             minFractionDigits="2"
                                                             maxFractionDigits="2"/>
                                    </c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </td>

                            <td>${livro.estoque}</td>

                            <td>${livro.status}</td>

                            <td class="acoes">
                                <a href="admin-livro-editar.html?id=${livro.id}" class="btn-editar">Editar</a>
                                <button class="btn-excluir"
                                        onclick="return confirmarExclusao()">Excluir</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

    </main>
</div>

<footer>
    Área Administrativa - Livraria © 2026
</footer>

<script>
    function confirmarExclusao() {
        return confirm("Deseja realmente excluir este livro?");
    }
</script>

</body>
</html>
