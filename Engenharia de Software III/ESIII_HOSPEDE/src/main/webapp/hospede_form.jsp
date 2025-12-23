<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.example.model.Hospede"%>
<%
    Hospede h = (Hospede) request.getAttribute("hospede");
    if (h == null) h = new Hospede();
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Hóspede</title>
    <style>
        body{
        font-family:Arial;
        margin:0;
        background:#f5f5f5
        }
        .top-bar{
        background:#0e3a5d;
        color:#fff;
        padding:18px 30px;
        font-weight:700
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
        .form-container{
        background:#fff;
        padding:25px;
        border-radius:8px;
        max-width:1000px;
        margin:auto;
        box-shadow:0 2px 8px rgba(0,0,0,.08)
        }
        .form-grid{
        display:grid;
        grid-template-columns:repeat(2,1fr);
        gap:12px}
        .address-block{
        background:#fbf7e8;
        padding:12px;
        border-radius:6px;
        margin-top:8px;
        border:1px solid #edd8a8}
        .btn-add{
        background:#1d79b0;
        color:#fff;
        border:none;
        padding:8px 12px;
        border-radius:6px;
        cursor:pointer
        }
        .btn-save{
        background:#1d79b0;
        color:#fff;
        padding:10px 18px;
        border-radius:6px;
        border:none;
        cursor:pointer}
        .btn-cancel{
        background:#b94a48;
        color:#fff;
        padding:10px 18px;
        border-radius:6px;
        border:none;
        cursor:pointer
        }
        .small{
        font-size:13px;
        color:#444
        }
    </style>
</head>
<body>
<div class="top-bar">🏨 HOTEL PRIME</div>
<div class="sidebar">
    <a href="index.jsp">Home</a>
    <a href="hospede?action=list">Hóspedes</a>
</div>

<div class="content">
  <div class="form-container">
    <h2>Cadastro / Edição de Hóspede</h2>

    <form action="hospede" method="post" id="hospedeForm">
      <input type="hidden" name="action" value="save"/>
      <input type="hidden" name="id" value="<%= h.getId() != null ? h.getId() : "" %>"/>

      <div class="form-grid">
        <label>Nome</label>
        <input type="text" name="nome" value="<%= h.getNome()!=null? h.getNome() : "" %>" required/>
        <label>CPF</label>
        <input type="text" name="cpf" value="<%= h.getCpf()!=null? h.getCpf() : "" %>" required/>
        <label>E-mail</label>
        <input type="email" name="email" value="<%= h.getEmail()!=null? h.getEmail() : "" %>" required/>
        <label>Telefone</label>
        <input type="text" name="telefone" value="<%= h.getTelefone()!=null? h.getTelefone() : "" %>" required/>
        <label>Celular</label>
        <input type="text" name="celular" value="<%= h.getCelular()!=null? h.getCelular() : "" %>"/>
        <label>Data Nascimento</label>
        <input type="date" name="data_nascimento" value="<%= h.getDataNascimento()!=null? h.getDataNascimento() : "" %>" required/>
        <label>Senha (deixe em branco para manter)</label>
        <input type="password" name="senha" value=""/>
        <label>Ativo</label>
        <input type="checkbox" name="ativo" <%= h.isAtivo() ? "checked" : "" %> />
      </div>

      <h3>Endereços</h3>
      <div id="addresses">

      <%
          if (h.getEnderecos() != null && !h.getEnderecos().isEmpty()) {
              int i = 1;
              for (var e : h.getEnderecos()) {
      %>
          <div class="address-block">
            <div class="small">
              Endereço #<%= i %>
              <button type="button" class="removeAddress" style="float:right">Remover</button>
            </div>

            Logradouro: <input type="text" name="logradouro[]" value="<%= e.getLogradouro() %>" /><br/>
            Número: <input type="text" name="numero[]" value="<%= e.getNumero() %>" /><br/>
            Complemento: <input type="text" name="complemento[]" value="<%= e.getComplemento() %>"/><br/>
            Bairro: <input type="text" name="bairro[]" value="<%= e.getBairro() %>" /><br/>
            Cidade (nome): <input type="text" name="cidade[]" value="<%= e.getCidade().getNome() %>" /><br/>
            Estado (nome): <input type="text" name="estado[]" value="<%= e.getEstado().getNome() %>" /><br/>
          </div>

      <%
              i++;
              }
          } else {
      %>

          <div class="address-block">
            <div class="small">Endereço #1</div>
            Logradouro: <input type="text" name="logradouro[]" /><br/>
            Número: <input type="text" name="numero[]" /><br/>
            Complemento: <input type="text" name="complemento[]" /><br/>
            Bairro: <input type="text" name="bairro[]" /><br/>
            Cidade (nome): <input type="text" name="cidade[]" /><br/>
            Estado (nome): <input type="text" name="estado[]" /><br/>
          </div>
      <%
          }
      %>
      </div>


      <div style="margin-top:8px">
        <button type="button" id="addAddress" class="btn-add">+ Adicionar endereço</button>
      </div>

      <div style="margin-top:18px">
        <button class="btn-save" type="submit">Salvar</button>
        <a href="hospede?action=list"><button type="button" class="btn-cancel" onclick="window.location='hospede?action=list'">Cancelar</button></a>
      </div>
    </form>
  </div>
</div>

<script>
  const addresses = document.getElementById('addresses');
  let count = <%= (h.getEnderecos() != null ? h.getEnderecos().size() : 1) %>;

  function addRemoveListener(div) {
      const btn = div.querySelector(".removeAddress");
      if (btn) {
        btn.addEventListener("click", () => div.remove());
      }
  }
  document.querySelectorAll(".address-block").forEach(addRemoveListener);

  document.getElementById("addAddress").addEventListener("click", () => {
      count++;
      const div = document.createElement("div");
      div.className = "address-block";
      div.innerHTML = `
        <div class="small">Endereço #${count}
          <button type="button" class="removeAddress" style="float:right">Remover</button>
        </div>

        Logradouro: <input type="text" name="logradouro[]" /><br/>
        Número: <input type="text" name="numero[]" /><br/>
        Complemento: <input type="text" name="complemento[]" /><br/>
        Bairro: <input type="text" name="bairro[]" /><br/>
        Cidade (nome): <input type="text" name="cidade[]" /><br/>
        Estado (nome): <input type="text" name="estado[]" /><br/>
      `;

      addresses.appendChild(div);
      addRemoveListener(div);
  });
</script>


</body>
</html>
