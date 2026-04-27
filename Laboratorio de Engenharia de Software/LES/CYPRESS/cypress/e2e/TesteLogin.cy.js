import home from "../pages/home";
import login from "../pages/login/TesteIndex.js";

describe('Login', () => {

    beforeEach(() => {
        // arrange
        login.visitarPagina()
        login.validar('estrutura')
        login.validar('atributos')
    })

    afterEach(() => {
        // assert
        login.validar()
    })

    it('Realizar login sem preencher senha', () => {

        // act
        login.preencherCampo('username', 'rita')
        login.clicarBotao('entrar')

        // assert
        login.validar('semSenha')
    })


    it('Realizar login sem preencher email', () => {

        // act
        login.preencherCampo('password', 'rita')
        login.clicarBotao('entrar')

        // assert
        login.validar('semEmail')
    })


    it('Realizar login sem preencher nenhum campo', () => {

        // act
        login.clicarBotao('entrar')

        // assert
        login.validar('camposObrigatorios')
    })


    it('Realizar login com email em formato inválido', () => {

        // act
        login.preencherCampo('username', 'emailinvalido')
        login.preencherCampo('password', 'rita')
        login.clicarBotao('entrar')

        // assert
        login.validar('emailFormatoInvalido')
    })


    it('Realizar login com credenciais inválidas', () => {

        // act
        login.preencherCampo('username', 'emailerrado@gmail.com')
        login.preencherCampo('password', 'senhaErrada.')
        login.clicarBotao('entrar')

        // assert
        login.validar('credenciaisInvalidas')
    })


    it('Realizar login com senha errada', () => {

        // act
        login.preencherCampo('username', 'rita')
        login.preencherCampo('password', 'SenhaErrada')
        login.clicarBotao('entrar')

        // assert
        login.validar('credenciaisInvalidas')
    })


    it('Realizar login com email errado', () => {

        // act
        login.preencherCampo('username', 'emailerrado@gmail.com')
        login.preencherCampo('password', 'rita')
        login.clicarBotao('entrar')

        // assert
        login.validar('credenciaisInvalidas')
    })


    it('Realizar login com cliente inativo', () => {

        // act
        login.preencherCampo('username', 'odete')
        login.preencherCampo('password', 'odete')
        login.clicarBotao('entrar')

        // assert
        login.validar('clienteInativo')
    })


    it('Realizar login com sucesso', () => {

        // act
        login.preencherCampo('username', 'rita')
        login.preencherCampo('password', 'rita')
        login.clicarBotao('entrar')

        // assert
        login.validar()
        home.validarAcessoPagina()
    })

})