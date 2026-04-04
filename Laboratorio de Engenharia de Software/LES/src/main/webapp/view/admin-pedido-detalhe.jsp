<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Admin - Detalhe do Pedido</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Serif+Display&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/admin.css">
</head>

<body>

<header class="topbar">
    <h1>Detalhe do Pedido #0001</h1>
    <div>
        <a href="admin-pedidos.jsp">Voltar</a>
        <a href="login.jsp">Sair</a>
    </div>
</header>

<div class="layout">

    <aside class="sidebar">
        <h2>Admin</h2>
        <nav>
            <a href="admin.jsp">Dashboard</a>
            <a href="admin-pedidos.jsp" class="active">Pedidos</a>
            <a href="admin-livros.html">Livros</a>
            <a href="admin-clientes.jsp">Clientes</a>
            <a href="admin-devolucoes.html">Devoluções</a>
            <a href="admin-relatorios.html">Relatórios</a>
        </nav>
    </aside>

    <main class="content">

        <h2>Informações do Pedido</h2>

        <table>
            <tr>
                <th>Número do Pedido</th>
                <td>#0001</td>
            </tr>
            <tr>
                <th>Data</th>
                <td>22/02/2026</td>
            </tr>
            <tr>
                <th>Status</th>
                <td>Enviado</td>
            </tr>
            <tr>
                <th>Forma de Pagamento</th>
                <td>Cartão de Crédito</td>
            </tr>
        </table>

        <br>

        <h2>Informações do Cliente</h2>

        <table>
            <tr>
                <th>Nome</th>
                <td>Maria Silva</td>
            </tr>
            <tr>
                <th>Email</th>
                <td>maria@email.com</td>
            </tr>
            <tr>
                <th>Telefone</th>
                <td>(11) 99999-9999</td>
            </tr>
        </table>

        <br>

        <h2>Endereço de Entrega</h2>

        <table>
            <tr>
                <th>Endereço</th>
                <td>Rua das Flores, 123</td>
            </tr>
            <tr>
                <th>Cidade</th>
                <td>São Paulo</td>
            </tr>
            <tr>
                <th>CEP</th>
                <td>01000-000</td>
            </tr>
        </table>

        <br>

        <h2>Itens do Pedido</h2>

        <table>
            <thead>
            <tr>
                <th>Livro</th>
                <th>Quantidade</th>
                <th>Preço Unitário</th>
                <th>Subtotal</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Dom Casmurro</td>
                <td>1</td>
                <td>R$ 39,90</td>
                <td>R$ 39,90</td>
            </tr>
            <tr>
                <td>O Cortiço</td>
                <td>2</td>
                <td>R$ 75,00</td>
                <td>R$ 150,00</td>
            </tr>
            </tbody>
        </table>

        <br>

        <h2>Resumo Financeiro</h2>

        <table>
            <tr>
                <th>Subtotal</th>
                <td>R$ 189,90</td>
            </tr>
            <tr>
                <th>Frete</th>
                <td>R$ 0,00</td>
            </tr>
            <tr>
                <th>Total</th>
                <td><strong>R$ 189,90</strong></td>
            </tr>
        </table>

        <br>

        <div class="form-actions">
            <a href="admin-pedido-editar.html" class="btn-editar">Editar Pedido</a>
            <a href="admin-devolucoes.html" class="btn-visualizar">Registrar Devolução</a>
            <button class="btn-excluir" onclick="return confirm('Deseja cancelar este pedido?')">
                Cancelar Pedido
            </button>
        </div>

    </main>
</div>

<footer>
    Área Administrativa - Livraria © 2026
</footer>

</body>
</html>