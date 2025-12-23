<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="java.util.List"%>
<%@page import="com.example.model.Hospede"%>

<%
    List<Hospede> hospedes = (List<Hospede>) request.getAttribute("hospedes");
    if (hospedes == null) hospedes = new java.util.ArrayList<>();
    String qNome = request.getParameter("nome") != null ? request.getParameter("nome") : "";
    String qCpf  = request.getParameter("cpf") != null ? request.getParameter("cpf") : "";
    String qEmail= request.getParameter("email") != null ? request.getParameter("email") : "";
    String qTel  = request.getParameter("telefone") != null ? request.getParameter("telefone") : "";
%>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Lista de Hóspedes</title>
        <style>
            body{
            font-family:Arial;
            background:#f5f5f5;
            margin:0
            }
            .top-bar{
            background:#0e3a5d;
            color:#fff;
            padding:18px 30px
            }
            .sidebar{
            width:180px;
            background:#dce8f2;
            height:100vh;
            position:fixed;
            top:80px;
            left:0;
            padding-top:20px
            }
            .content{
            margin-left:200px;
            padding:30px
            }
            .table-container{
            margin-top:18px
            }
            table{
            width:100%;
            border-collapse:collapse;
            background:#f7edcf
            }
            table th,td{
            padding:8px;
            border:1px solid #efdca8;
            text-align:center
            }
            .filter-box{
            background:#fff;
            padding:12px;
            border-radius:6px
            }
            .filter-grid{
            display:grid;
            grid-template-columns:repeat(4,1fr);
            gap:8px
            }
            .filter-btn{
            background:#1d79b0;
            color:#fff;
            padding:8px 12px;
            border-radius:6px;
            border:none;
            cursor:pointer
            }
        </style>
    </head>
<body>
    <div class="top-bar">🏨 HOTEL PRIME</div>
    <div class="sidebar"><a href="index.jsp">Home</a><a href="hospede?action=form">Novo Hóspede</a></div>

    <div class="content">
      <h2>Hóspedes</h2>

      <div class="filter-box">
        <form method="get" action="hospede">
          <input type="hidden" name="action" value="list"/>
          <div class="filter-grid">
            <input type="text" name="nome" placeholder="Nome" value="<%= qNome %>"/>
            <input type="text" name="cpf" placeholder="CPF" value="<%= qCpf %>"/>
            <input type="email" name="email" placeholder="E-mail" value="<%= qEmail %>"/>
            <input type="text" name="telefone" placeholder="Telefone" value="<%= qTel %>"/>
          </div>
          <div style="margin-top:10px; text-align:right;">
            <button class="filter-btn" type="submit">Filtrar</button>
          </div>
        </form>
      </div>

      <div class="table-container">
        <table>
          <thead>
            <tr><th></th><th>ID</th><th>Nome</th><th>E-mail</th><th>Telefone</th><th>Status</th><th>Ação</th></tr>
          </thead>
          <tbody>
          <% for (Hospede h : hospedes) { %>
            <tr>
              <td><input type="checkbox"/></td>
              <td><%= h.getId() %></td>
              <td><%= h.getNome() %></td>
              <td><%= h.getEmail() %></td>
              <td><%= h.getTelefone() %></td>
              <td><%= h.isAtivo() ? "Hab" : "Des" %></td>
              <td>
                <a href="hospede?action=edit&id=<%= h.getId() %>">Editar</a> |
                <a href="hospede?action=delete&id=<%= h.getId() %>" onclick="return confirm('Excluir?')">Excluir</a>
              </td>
            </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
</body>
</html>
