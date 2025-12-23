<%@page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Hotel Prime - Sistema</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f5f5;
}

.top-bar {
    background: #0e3a5d;
    color: #fff;
    padding: 25px 40px;
    font-size: 28px;
    font-weight: bold;
}

.sidebar {
    width: 180px;
    background: #dce8f2;
    height: 100vh;
    padding-top: 40px;
    position: fixed;
    top: 100px;
    left: 0;
}

.sidebar a {
    display: block;
    padding: 12px 25px;
    text-decoration: none;
    color: #333;
    font-size: 14px;
}

.sidebar a:hover {
    background: #c9d9e3;
}

.content {
    margin-left: 200px;
    padding: 40px;
}

.content h1 {
    font-size: 32px;
}

</style>
</head>

<body>

<div class="top-bar">
    🏨 HOTEL PRIME
</div>

<div class="sidebar">
    <a href="index.jsp">Home</a>
    <a href="hospede?action=list">Listar Hóspedes</a>
    <a href="hospede?action=form">Cadastrar Hóspede</a>
</div>

<div class="content">
    <h1>Bem-vindo ao Sistema</h1>
    <p>Use o menu lateral para navegar</p>
</div>

</body>
</html>
