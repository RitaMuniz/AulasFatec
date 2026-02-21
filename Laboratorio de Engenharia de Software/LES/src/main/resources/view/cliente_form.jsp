<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Livraria</title>
     <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <div class="sidebar">
           <a href="index.jsp">Home</a>
          <a href="cliente?action=list">Listar Clientes</a>
    </div>

    <div class="content">
      <div class="form-container">
        <h2>Cadastro / Edição de Cliente</h2>

        <form action="cliente" method="post" id=clienteForm">
          <input type="hidden" name="action" value="save"/>
          <input type="hidden" name="id"/>

          <div class="form-grid">
            <label>Nome</label>
            <input type="text" name="nome" required/>
            <label>Gênero</label>
            <input type="text" name="genero" required/>
            <label>CPF</label>
            <input type="text" name="cpf" required/>
            <label>E-mail</label>
            <input type="email" name="email"  required/>
            <label>Telefone</label>
            <input type="text" name="telefone" required/>
            <label>Data Nascimento</label>
            <input type="date" name="data_nascimento" required/>
            <label>Senha (deixe em branco para manter)</label>
            <input type="password" name="senha" value="" required/>
            <label>Ativo</label>
            <input type="checkbox" name="ativo" />
          </div>

          <div style="margin-top:18px">
            <button class="btn-save" type="submit">Salvar</button>
            <a href="cliente?action=list"><button type="button" class="btn-cancel" onclick="window.location='cliente?action=list'">Cancelar</button></a>
          </div>
        </form>
      </div>
    </div>



    <%--
        /*
            Gênero,
            Nome,
            Data de Nascimento,
            CPF,
            Telefone (deve ser composto pelo tipo, DDD e número),
            e-mail,
            senha,
            endereço de cobrança e de entrega: Tipo de residência (Casa, Apartamento, etc),
                                               Tipo Logradouro,
                                               Logradouro,
                                               Número,
                                               Bairro,
                                               CEP,
                                               Cidade,
                                               Estado e
                                               País.
                                               Opcionalmente pode ser preenchido um campo observações.
            Cartão de crédito: Nº do Cartão,
                               Nome impresso no Cartão,
                               Bandeira do Cartão e
                               Código de Segurança.
        */
    --%>
</body>
</html>
