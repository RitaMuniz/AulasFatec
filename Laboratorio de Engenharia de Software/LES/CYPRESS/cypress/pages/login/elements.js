export const elements = {
    telaLogin: 'http://localhost:8080/LES/view/login.jsp',
    username: '[data-test="email"]',
    password: '[data-test="senha"]',
    loginButton: '[data-test="entrar"]',
    entrar: '[data-test="entrar"]',
    errorMessageClienteInativo: '[data-test="erro_cliente_inativo"]',
    linkMessageClienteInativo: 'http://localhost:8080/LES/view/login.jsp?erro=2',
    errorMessageLoginErrado:'[data-test="erro_login_errado"]',
    linkMessageLoginErrado: 'http://localhost:8080/LES/view/login.jsp?erro=1',

    validarMensagemNavegador($input) {
        expect($input[0].checkValidity()).to.be.false
    }
}