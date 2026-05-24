import login from "../pages/login/TesteIndex"
import perfil from "../pages/Perfil/TesteIndex"

import usuarios from "../fixtures/usuarios.json"
import home from "../pages/home/TesteIndex";

describe('Perfil do Cliente', () => {

    beforeEach(() => {

        cy.resetarBanco()

        login.visitarPagina()

        login.preencherCampo('username', usuarios.maria.email)

        login.preencherCampo('password', usuarios.maria.senha)

        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('meu_perfil')


    })

    afterEach(() => {
        cy.resetarBanco()
    })

    // =========================================
    // VALIDAÇÕES
    // =========================================

    it('Deve validar estrutura da página', () => {

        perfil.validar('estrutura')
    })

    it('Deve validar acesso da página', () => {

        perfil.validar('acessoPagina')
    })

    it('Deve validar navbar', () => {

        perfil.validar('navbar')
    })

    it('Deve validar campos', () => {

        perfil.validar('campos')
    })

    it('Deve validar botões', () => {

        perfil.validar('botoes')
    })

    it('Deve validar página automaticamente', () => {

        perfil.validar()
    })

    // =========================================
    // EDIÇÕES
    // =========================================

    it('Deve alterar nome', () => {

        perfil.campo('nome', 'Cliente Cypress')

        perfil.validarCampo('nome', 'Cliente Cypress')

        perfil.clicarBotao('salvar')

        cy.url()
            .should('contain', 'sucesso')
    })

    it('Deve alterar email', () => {

        perfil.campo('email', 'cliente@email.com')

        perfil.validarCampo('email', 'cliente@email.com')

        perfil.clicarBotao('salvar')

        cy.url()
            .should('contain', 'sucesso')
    })

    it('Deve alterar gênero', () => {

        perfil.campo('genero', 'M')

        perfil.validarCampo('genero', 'M')

        perfil.clicarBotao('salvar')

        cy.url()
            .should('contain', 'sucesso')
    })

    // =========================================
    // LINKS
    // =========================================

    it('Deve acessar endereços', () => {

        perfil.clicarBotao('endereco')

        cy.url()
            .should('include', '/endereco')
    })

    it('Deve acessar cartões', () => {

        perfil.clicarBotao('cartoes')

        cy.url()
            .should('include', '/cartao')
    })

    it('Deve acessar pedidos', () => {

        perfil.clicarBotao('pedidos')

        cy.url()
            .should('include', '/pedidos')
    })
})