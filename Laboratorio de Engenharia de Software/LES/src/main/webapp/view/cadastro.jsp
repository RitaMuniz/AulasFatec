<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/css/style.css">
</head>
<body>

<header class="navbar">
    <div class="logo">Livraria</div>
    <nav>
        <a href="index.jsp">Home</a>
        <a href="login.jsp">Entrar</a>
    </nav>
</header>

<div class="container" style="max-width:600px; margin:40px auto;">
    <div class="form-box">
        <h2 style="margin-bottom:24px; text-align:center;">Criar Conta</h2>

        <form action="${pageContext.request.contextPath}/cliente" method="post" id="formCadastro">
            <input type="hidden" name="action" value="cadastrar">

            <label for="nome">Nome Completo *</label>
            <input type="text" id="nome" name="nome" placeholder="Seu nome completo" required minlength="3">

            <label for="email">E-mail *</label>
            <input type="email" id="email" name="email" placeholder="seu@email.com" required>

            <label for="cpf">CPF *</label>
            <input type="text" id="cpf" name="cpf" placeholder="000.000.000-00" maxlength="14" required>

            <label for="genero">Gênero *</label>
            <select id="genero" name="genero" required style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px;">
                <option value="">Selecione</option>
                <option value="F">Feminino</option>
                <option value="M">Masculino</option>
                <option value="O">Outro</option>
                <option value="N">Prefiro não informar</option>
            </select>

            <label for="dataNascimento">Data de Nascimento *</label>
            <input type="date" id="dataNascimento" name="dataNascimento" required>

            <label for="senha">Senha *</label>
            <input type="password" id="senha" name="senha"
                   placeholder="Mínimo 8 caracteres" required minlength="8">
            <ul id="requisitos-senha" style="font-size:12px; color:#666; margin:-8px 0 12px 16px; padding:0; list-style:disc;">
                <li id="req-tamanho">Mínimo 8 caracteres</li>
                <li id="req-maiuscula">Pelo menos uma letra maiúscula</li>
                <li id="req-numero">Pelo menos um número</li>
                <li id="req-especial">Pelo menos um caractere especial (!@#$%...)</li>
            </ul>

            <label for="confirmarSenha">Confirmar Senha *</label>
            <input type="password" id="confirmarSenha" name="confirmarSenha"
                   placeholder="Repita a senha" required>
            <p id="msg-senha" style="font-size:12px; color:#b00020; display:none; margin-top:-10px; margin-bottom:10px;">As senhas não coincidem.</p>

            <hr style="margin:24px 0; border:none; border-top:1px solid #eee;">

            <h3 style="margin-bottom:16px;">Telefone *</h3>

            <label for="tipoTelefone">Tipo *</label>
            <select id="tipoTelefone" name="tipoTelefone" required style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px;">
                <option value="">Selecione</option>
                <option value="CELULAR">Celular</option>
                <option value="RESIDENCIAL">Residencial</option>
                <option value="COMERCIAL">Comercial</option>
            </select>

            <div style="display:flex; gap:12px;">
                <div style="flex:0 0 100px;">
                    <label for="ddd">DDD *</label>
                    <input type="text" id="ddd" name="ddd" placeholder="11" maxlength="2" required pattern="\d{2}">
                </div>
                <div style="flex:1;">
                    <label for="numeroTelefone">Número *</label>
                    <input type="text" id="numeroTelefone" name="numeroTelefone" placeholder="99999-9999" required>
                </div>
            </div>

            <hr style="margin:24px 0; border:none; border-top:1px solid #eee;">

            <h3 style="margin-bottom:4px;">Endereço de Entrega *</h3>
            <p style="font-size:12px; color:#888; margin-bottom:16px;">Usado para entrega dos seus pedidos.</p>
            <input type="hidden" name="tipoEndereco" value="ENTREGA">

            <label for="tipoResidencia">Tipo de Residência *</label>
            <input type="text" id="tipoResidencia" name="tipoResidencia" placeholder="Casa, Apartamento, etc." required>

            <label for="tipoLogradouro">Tipo de Logradouro *</label>
            <input type="text" id="tipoLogradouro" name="tipoLogradouro" placeholder="Rua, Avenida, etc." required>

            <label for="logradouro">Logradouro *</label>
            <input type="text" id="logradouro" name="logradouro" placeholder="Nome da rua/avenida" required>

            <label for="numeroEndereco">Número *</label>
            <input type="text" id="numeroEndereco" name="numeroEndereco" placeholder="123" required>

            <label for="bairro">Bairro *</label>
            <input type="text" id="bairro" name="bairro" placeholder="Seu bairro" required>

            <label for="cep">CEP *</label>
            <input type="text" id="cep" name="cep" placeholder="00000-000" maxlength="9" required pattern="\d{5}-?\d{3}">

            <label for="cidade">Cidade *</label>
            <input type="text" id="cidadeEntrega" name="cidadeNome" placeholder="Sua Cidade" required>

            <label>Estado</label>
            <select name="estadoIdEntrega" required style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px;">
                <option value="">Selecione</option>
                <c:forEach var="e" items="${estados}">
                    <option value="${e.id}">${e.nome}</option>
                </c:forEach>
            </select>

            <label for="observacoes">Observações (opcional)</label>
            <input type="text" id="observacoes" name="observacoes" placeholder="Complemento, referência...">


            <hr style="margin:24px 0; border:none; border-top:1px solid #eee;">

            <h3 style="margin-bottom:4px;">Endereço de Cobrança *</h3>
            <p style="font-size:12px; color:#888; margin-bottom:16px;">Usado para emissão de notas fiscais.</p>

            <div style="margin-bottom:16px;">
                <label style="display:flex; align-items:center; gap:8px; font-weight:normal; cursor:pointer;">
                    <input type="checkbox" id="mesmoEndereco" onchange="toggleEnderecoCobranca(this)">
                    Usar o mesmo endereço de entrega
                </label>
            </div>

            <div id="secaoCobranca">
                <input type="hidden" name="tipoEnderecoCobranca" value="COBRANCA">

                <label for="tipoResidenciaCobranca">Tipo de Residência *</label>
                <input type="text" id="tipoResidenciaCobranca" name="tipoResidenciaCobranca" placeholder="Casa, Apartamento, etc." required>

                <label for="tipoLogradouroCobranca">Tipo de Logradouro *</label>
                <input type="text" id="tipoLogradouroCobranca" name="tipoLogradouroCobranca" placeholder="Rua, Avenida, etc." required>

                <label for="logradouroCobranca">Logradouro *</label>
                <input type="text" id="logradouroCobranca" name="logradouroCobranca" placeholder="Nome da rua/avenida" required>

                <label for="numeroEnderecoCobranca">Número *</label>
                <input type="text" id="numeroEnderecoCobranca" name="numeroEnderecoCobranca" placeholder="123" required>

                <label for="bairroCobranca">Bairro *</label>
                <input type="text" id="bairroCobranca" name="bairroCobranca" placeholder="Seu bairro" required>

                <label for="cepCobranca">CEP *</label>
                <input type="text" id="cepCobranca" name="cepCobranca" placeholder="00000-000" maxlength="9" required pattern="\d{5}-?\d{3}">

                <label for="cidade">Cidade *</label>
                <input type="text" id="cidadeCobranca" name="cidadeNomeCobranca" placeholder="Sua Cidade" required>

                <label>Estado</label>
                <select name="estadoIdCobranca" required style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #ccc; border-radius:6px;">
                    <option value="">Selecione</option>
                    <c:forEach var="e" items="${estados}">
                        <option value="${e.id}">${e.nome}</option>
                    </c:forEach>
                </select>

                <label for="observacoesCobranca">Observações (opcional)</label>
                <input type="text" id="observacoesCobranca" name="observacoesCobranca" placeholder="Complemento, referência...">

            </div>

            <button type="submit" class="btn" style="width:100%; margin-top:24px;">Cadastrar</button>
        </form>

        <p style="margin-top:15px; text-align:center;">
            Já possui conta? <a href="login.jsp">Entrar</a>
        </p>
    </div>
</div>

<footer>Livraria © 2026</footer>

<script>
    const senhaInput = document.getElementById('senha');
    const confirmarInput = document.getElementById('confirmarSenha');
    const msgSenha = document.getElementById('msg-senha');

    const reqs = {
        'req-tamanho':  s => s.length >= 8,
        'req-maiuscula': s => /[A-Z]/.test(s),
        'req-numero':   s => /[0-9]/.test(s),
        'req-especial': s => /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(s)
    };

    senhaInput.addEventListener('input', function () {
        const v = this.value;
        for (const [id, fn] of Object.entries(reqs)) {
            const li = document.getElementById(id);
            li.style.color = fn(v) ? 'green' : '#666';
        }
        verificarCoincidem();
    });

    confirmarInput.addEventListener('input', verificarCoincidem);

    function verificarCoincidem() {
        const ok = senhaInput.value === confirmarInput.value;
        msgSenha.style.display = (confirmarInput.value.length > 0 && !ok) ? 'block' : 'none';
    }

    //Checkbox "mesmo endereço"
    function toggleEnderecoCobranca(cb) {
        const secao = document.getElementById('secaoCobranca');
        const inputs = secao.querySelectorAll('input:not([type=hidden]), select');
        if (cb.checked) {
            secao.style.display = 'none';
            inputs.forEach(i => i.removeAttribute('required'));
        } else {
            secao.style.display = 'block';
            inputs.forEach(i => {
                // Só restaura required nos que não são "observações"
                if (!i.id.includes('observacoes')) i.setAttribute('required', '');
            });
        }
    }

    //Validação final antes de enviar
    document.getElementById('formCadastro').addEventListener('submit', function (e) {
        const senha = senhaInput.value;

        const todosOk = Object.values(reqs).every(fn => fn(senha));
        if (!todosOk) {
            e.preventDefault();
            alert('A senha não atende a todos os requisitos de segurança.');
            senhaInput.focus();
            return;
        }

        if (senha !== confirmarInput.value) {
            e.preventDefault();
            alert('As senhas não coincidem.');
            confirmarInput.focus();
            return;
        }

        const cpf = document.getElementById('cpf').value.replace(/\D/g, '');
        if (cpf.length !== 11) {
            e.preventDefault();
            alert('CPF inválido. Informe os 11 dígitos.');
            document.getElementById('cpf').focus();
            return;
        }
    });

    document.getElementById('cpf').addEventListener('input', function () {
        let v = this.value.replace(/\D/g, '').substring(0, 11);
        if (v.length > 9) v = v.replace(/(\d{3})(\d{3})(\d{3})(\d{0,2})/, '$1.$2.$3-$4');
        else if (v.length > 6) v = v.replace(/(\d{3})(\d{3})(\d{0,3})/, '$1.$2.$3');
        else if (v.length > 3) v = v.replace(/(\d{3})(\d{0,3})/, '$1.$2');
        this.value = v;
    });

    ['cep', 'cepCobranca'].forEach(id => {
        const el = document.getElementById(id);
        if (el) el.addEventListener('input', function () {
            let v = this.value.replace(/\D/g, '').substring(0, 8);
            if (v.length > 5) v = v.replace(/(\d{5})(\d{0,3})/, '$1-$2');
            this.value = v;
        });
    });
</script>

</body>
</html>
