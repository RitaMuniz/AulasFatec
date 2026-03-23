<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    projetoLivraria.model.Cliente clienteLogado =
        (projetoLivraria.model.Cliente) session.getAttribute("clienteLogado");
    if (clienteLogado == null) {
        response.sendRedirect("/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Meu Perfil</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
</head>
<body>

<header class="navbar">
    <div class="logo">Livraria</div>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="livros.html">Livros</a>
        <a href="carrinho.html">Carrinho</a>
        <a href="logout">Sair</a>
    </nav>
</header>

<div class="container" style="max-width:640px; margin:40px auto;">

    <h1 style="margin-bottom:30px;">Meu Perfil</h1>

    <div class="form-box" style="margin-bottom:30px;">
        <h2 style="margin-bottom:20px;">Dados Pessoais</h2>

        <form action="/cliente" method="post">
            <input type="hidden" name="action" value="editar">
            <input type="hidden" name="id" value="<%= clienteLogado.getId() %>">

            <label for="nome">Nome Completo</label>
            <input type="text" id="nome" name="nome"
                   value="<%= clienteLogado.getNome() != null ? clienteLogado.getNome() : "" %>" required>

            <label for="genero">Gênero</label>
            <select id="genero" name="genero" style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px;">
                <option value="">Selecione</option>
                <option value="F" <%= "F".equals(clienteLogado.getGenero()) ? "selected" : "" %>>Feminino</option>
                <option value="M" <%= "M".equals(clienteLogado.getGenero()) ? "selected" : "" %>>Masculino</option>
                <option value="O" <%= "O".equals(clienteLogado.getGenero()) ? "selected" : "" %>>Outro</option>
                <option value="N" <%= "N".equals(clienteLogado.getGenero()) ? "selected" : "" %>>Prefiro não informar</option>
            </select>

            <label for="dataNascimento">Data de Nascimento</label>
            <input type="date" id="dataNascimento" name="dataNascimento"
                   value="<%= clienteLogado.getDataNascimento() != null ? clienteLogado.getDataNascimento().toString() : "" %>" required>

            <label for="email">E-mail</label>
            <input type="email" id="email" name="email"
                   value="<%= clienteLogado.getEmail() != null ? clienteLogado.getEmail() : "" %>" required>

            <button type="submit" class="btn" style="margin-top:10px;">Salvar Alterações</button>
        </form>
    </div>

    <div class="form-box" style="margin-bottom:30px; border:1px solid #f5c6cb;">
        <h2 style="margin-bottom:10px; color:#b00020;">Desativar Conta</h2>
        <p style="margin-bottom:16px; font-size:14px;">Ao desativar sua conta, você não poderá mais fazer login.</p>

        <form action="/cliente" method="post"
              onsubmit="return confirm('Tem certeza que deseja desativar sua conta?')">
            <input type="hidden" name="action" value="desativar">
            <input type="hidden" name="id" value="<%= clienteLogado.getId() %>">
            <button type="submit" class="btn" style="background:#b00020;">Desativar Conta</button>
        </form>
    </div>

    <div style="display:flex; gap:15px; justify-content:center; flex-wrap:wrap;">
        <a href="endereco?action=listar" class="btn">Gerenciar Endereços</a>
        <a href="cartao?action=listar" class="btn">Gerenciar Cartões</a>
        <a href="pedidos.html" class="btn">Meus Pedidos</a>
    </div>

</div>

<footer>Livraria © 2026</footer>

</body>
</html>