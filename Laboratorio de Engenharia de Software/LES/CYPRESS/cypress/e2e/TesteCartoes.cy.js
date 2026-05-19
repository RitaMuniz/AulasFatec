import login from "../pages/login/TesteIndex"
import perfil from "../pages/Perfil/TesteIndex"
import cartoes from "../pages/Cartoes/TesteIndex"
import home from "../pages/home/TesteIndex"

import usuarios from "../fixtures/usuarios.json"

describe('Cartões do Cliente', () => {

    beforeEach(() => {

        cy.resetarBanco()

        login.visitarPagina()

        login.preencherCampo('username', usuarios.maria.email)

        login.preencherCampo('password', usuarios.maria.senha)

        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('meu_perfil')

        perfil.clicarBotao('cartoes')
    })

    afterEach(() => {

        cy.resetarBanco()
    })

    // =========================================
    // VALIDAÇÕES
    // =========================================

    it('Deve validar página automaticamente', () => {

        cartoes.validar()
    })

    // =========================================
    // CADASTRO
    // =========================================

    it('Deve adicionar cartão', () => {

        cartoes.campo('nome', 'Maria Silva')

        cartoes.campo('numero', '1234123412341234')

        cartoes.campo('validade', '12/30')

        cartoes.campo('bandeira', '1')

        cartoes.campo('cvv', '123')

        cartoes.clicarBotao('adicionar')

        cy.contains('Maria Silva')
            .should('exist')
    })

    // =========================================
    // EXCLUSÃO
    // =========================================

    it('Deve excluir cartão', () => {

        cy.on('window:confirm', () => true)

        cartoes.clicarBotao('excluir')
    })

    // =========================================
    // CAMPOS OBRIGATÓRIOS
    // =========================================

    it('Não deve adicionar cartão sem nome', () => {

        cartoes.campo('numero', '1234123412341234')

        cartoes.campo('validade', '12/30')

        cartoes.campo('bandeira', '1')

        cartoes.campo('cvv', '123')

        cartoes.clicarBotao('adicionar')

        cy.url()
            .should('include', '/cartao')
    })

    it('Não deve adicionar cartão sem número', () => {

        cartoes.campo('nome', 'Maria Silva')

        cartoes.campo('validade', '12/30')

        cartoes.campo('bandeira', '1')

        cartoes.campo('cvv', '123')

        cartoes.clicarBotao('adicionar')

        cy.url()
            .should('include', '/cartao')
    })

    it('Não deve adicionar cartão sem validade', () => {

        cartoes.campo('nome', 'Maria Silva')

        cartoes.campo('numero', '1234123412341234')

        cartoes.campo('bandeira', '1')

        cartoes.campo('cvv', '123')

        cartoes.clicarBotao('adicionar')

        cy.url()
            .should('include', '/cartao')
    })

    it('Não deve adicionar cartão sem bandeira', () => {

        cartoes.campo('nome', 'Maria Silva')

        cartoes.campo('numero', '1234123412341234')

        cartoes.campo('validade', '12/30')

        cartoes.campo('cvv', '123')

        cartoes.clicarBotao('adicionar')

        cy.url()
            .should('include', '/cartao')
    })

    it('Não deve adicionar cartão sem cvv', () => {

        cartoes.campo('nome', 'Maria Silva')

        cartoes.campo('numero', '1234123412341234')

        cartoes.campo('validade', '12/30')

        cartoes.campo('bandeira', '1')

        cartoes.clicarBotao('adicionar')

        cy.url()
            .should('include', '/cartao')
    })

    // =========================================
    // VALORES INVÁLIDOS
    // =========================================

    /*it('Não deve adicionar cartão com validade inválida', () => {

        cartoes.campo('nome', 'Maria Silva')

        cartoes.campo('numero', '1234123412341234')

        cartoes.campo('validade', '99/99')

        cartoes.campo('bandeira', '1')

        cartoes.campo('cvv', '123')

        cartoes.clicarBotao('adicionar')

        cy.url()
            .should('include', '/cartao')
    })*/

    /*it('Não deve adicionar cartão com cvv inválido', () => {

        cartoes.campo('nome', 'Maria Silva')

        cartoes.campo('numero', '1234123412341234')

        cartoes.campo('validade', '12/30')

        cartoes.campo('bandeira', '1')

        cartoes.campo('cvv', '1')

        cartoes.clicarBotao('adicionar')

        cy.url()
            .should('include', '/cartao')
    })*/

    /*it('Não deve adicionar cartão com número inválido', () => {

        cartoes.campo('nome', 'Maria Silva')

        cartoes.campo('numero', '123')

        cartoes.campo('validade', '12/30')

        cartoes.campo('bandeira', '1')

        cartoes.campo('cvv', '123')

        cartoes.clicarBotao('adicionar')

        cy.url()
            .should('include', '/cartao')
    })*/
})