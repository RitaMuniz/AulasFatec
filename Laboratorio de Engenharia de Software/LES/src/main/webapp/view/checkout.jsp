<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrinho</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
</head>
<body>

<html>
<head>
    <title>Checkout</title>
</head>
<body>

<h2>Finalizar Pedido</h2>

<form action="pedido" method="POST">

    ```
    <h3>Endereço</h3>
    <select name="enderecoId">
        <c:forEach var="e" items="${enderecos}">
            <option value="${e.id}">${e.logradouro}</option>
        </c:forEach>
    </select>

    <h3>Pagamento</h3>

    <h4>Cartão 1</h4>
    <input type="number" name="cartao_id" placeholder="ID do cartão">
    <input type="text" name="valor_cartao" placeholder="Valor">

    <br><br>

    <h4>Cartão 2 (opcional)</h4>
    <input type="number" name="cartao_id">
    <input type="text" name="valor_cartao">

    <br><br>

    <h3>Cupom</h3>
    <input type="number" name="cupom_id" placeholder="ID do cupom">

    <br><br>

    <input type="hidden" name="frete" value="20.00">

    <button type="submit">Finalizar Pedido</button>
    ```

</form>

</body>
</html>