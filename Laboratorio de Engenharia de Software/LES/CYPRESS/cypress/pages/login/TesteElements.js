export const elements = {
    urls: {
        telaLogin: 'http://localhost:8080/LES/view/login.jsp',
        erroLogin: 'http://localhost:8080/LES/view/login.jsp?erro=1',
        erroClienteInativo: 'http://localhost:8080/LES/view/login.jsp?erro=2'
    },

    campos: {
        username: '[data-test="email"]',
        password: '[data-test="senha"]'
    },

    botoes: {
        entrar: '[data-test="entrar"]'
    },

    mensagens: {
        erroLogin: '[data-test="erro_login_errado"]',
        erroClienteInativo: '[data-test="erro_cliente_inativo"]'
    },

    textos: {
        erroLogin: 'E-mail ou senha inválidos.',
        erroClienteInativo: 'Sua conta está inativa. Entre em contato com o suporte.',
        placeholderEmail: 'seu@email.com',
        placeholderSenha: 'Sua senha'
    },

    atributos: {
        username: {
            type: 'email',
            required: 'required',
            placeholder: 'seu@email.com'
        },

        password: {
            type: 'password',
            required: 'required',
            placeholder: 'Sua senha'
        }
    },

    mapaCamposFixture: {
        username: 'email',
        password: 'senha'
    },

    validarMensagemNavegador($input) {
        expect($input[0].checkValidity()).to.be.false
    }
}