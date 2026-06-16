import home from "../pages/home";
import login from "../pages/login/TesteIndex.js";
import clientejson from "../fixtures/cliente.json";

describe('Login', () => {

    beforeEach(() => {
        // arrange
        login.visitarPagina()
        login.validar('estrutura')
        login.validar('atributos')
    })

    afterEach(function () {
        login.validar()
        login.print(this)
    })

    it('Realizar login sem preencher senha', () => {

        // act
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.clicarBotao('entrar')

        // assert
        login.validar('semSenha')
    })


    it('Realizar login sem preencher email', () => {

        // act
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
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
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
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
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', 'SenhaErrada')
        login.clicarBotao('entrar')

        // assert
        login.validar('credenciaisInvalidas')
    })


    it('Realizar login com email errado', () => {

        // act
        login.preencherCampo('username', 'emailerrado@gmail.com')
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        // assert
        login.validar('credenciaisInvalidas')
    })


    it('Realizar login com cliente inativo', () => {

        // act
        login.preencherCampo('username', clientejson["Aline Pereira"].email)
        login.preencherCampo('password', clientejson["Aline Pereira"].senha)
        login.clicarBotao('entrar')

        // assert
        login.validar('clienteInativo')
    })


    it('Realizar login com sucesso', () => {

        // act
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        // assert
        login.validar()
        home.validarAcessoPagina()
    })
    /*// cypress:open:dev funciona somente quando aberto assim
    it('Realizar login com sucesso .env', () => {

        // act
        login.preencherCampo('username', Cypress.env('username'))
        login.preencherCampo('password', Cypress.env('password'))
        login.clicarBotao('entrar')

        // assert
        login.validar()
        home.validarAcessoPagina()
    })*/

})