<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Meus Pedidos</title>

    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<header>
    <h1>Livraria</h1>
    <div>
        <a href="index.jsp">Início</a>
        <a href="livros.jsp">Livros</a>
        <a href="carrinho.jsp">Carrinho</a>
    </div>
</header>

<div class="container">
    <h2>Meus Pedidos</h2>

    <div class="pedido-card">
        <div>
            <p><strong>Pedido #0001</strong></p>
            <p>Data: 22/02/2026</p>
            <p class="status">Status: Enviado</p>
        </div>
        <button onclick="window.location.href='pedido.html'">Ver Detalhes</button>
    </div>

</div>

<footer>
    © 2026 Livraria - Todos os direitos reservados
</footer>

</body>
</html>