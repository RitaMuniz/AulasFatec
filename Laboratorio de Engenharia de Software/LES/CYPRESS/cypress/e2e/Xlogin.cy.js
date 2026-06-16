import home from "../pages/home";
import login from "../pages/login/index";

describe('Login', () => {

    beforeEach(() => {
        // arrange
        login.visitarPagina()
    })

    // Cliente tenta logar sem preencher senha
    it('Realizar login sem preencher senha', () => {

        // act
        login.preencherCredenciaisSemSenha()

        // assert
        login.validarCredenciasSemSenha()
    })

    // Cliente tenta logar sem preencher email
    it('Realizar login sem preencher email', () => {

        // act
        login.preencherCredenciaisSemEmail()

        // assert
        login.validarCredenciaisSemEmail()
    })

    // Cliente tenta logar sem preencher nenhum campo
    it('Realizar login sem preencher nenhum campo', () => {


        // act
        login.preencherCredenciaisComCampoVazio()

        // assert
        login.validarCredenciaisCampoVazio()
    })

    // Cliente preenche email e senha errado
    it('Realizar login com credenciais invalidas', () => {


        // act
        login.preencherCredenciaisEmaileSenhaErrado()

        // assert
        login.validarCredenciaisInvalidas()
    })

    // Cliente preenche senha errado
    it('Realizar login com senha errada', () => {

        // act
        login.preencherCredenciaisSenhaErrada()

        // assert
        login.validarCredenciaisInvalidas()
    })

    // Cliente preenche email inexistente com senha no banco
    it('Realizar login com email inexistente e senha no banco', () => {

        // act
        login.preencherCredenciaisEmailErrado()

        // assert
        login.validarCredenciaisInvalidas()
    })

    // cliente esta inativo
    it('Realizar login com cliente inativo', () => {
        // act
        login.preencherCredenciaisInativas()

        // assert
        login.validarCredenciaisClienteInativo()
    })


    // cliente logado com sucesso
    it('Realizar login com sucesso', () => {
        // act
        login.preencherCredenciaisValidas()

        // assert
        home.validarAcessoPagina()
    })


})