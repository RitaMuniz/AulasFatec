import login from "../pages/login/TesteIndex"
import perfil from "../pages/Perfil/TesteIndex"
import endereco from "../pages/Endereco/TesteIndex"
import home from "../pages/home/TesteIndex"

import usuarios from "../fixtures/usuarios.json"

describe('Endereço do Cliente', () => {

    beforeEach(() => {

        cy.resetarBanco()

        login.visitarPagina()

        login.preencherCampo('username', usuarios.maria.email)

        login.preencherCampo('password', usuarios.maria.senha)

        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('meu_perfil')

        perfil.clicarBotao('endereco')
    })

    afterEach(() => {

        cy.resetarBanco()
    })

    it('Não deve cadastrar endereço com campos vazios', () => {

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve cadastrar endereço somente com logradouro', () => {

        endereco.campo('logradouro', 'Rua Teste')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve cadastrar endereço somente com CEP', () => {

        endereco.campo('cep', '08700-000')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve cadastrar endereço com CEP inválido', () => {

        endereco.campo('tipoEndereco', 'ENTREGA')

        endereco.campo('tipoResidencia', 'Casa')

        endereco.campo('tipoLogradouro', 'Rua')

        endereco.campo('logradouro', 'Rua Teste')

        endereco.campo('numero', '123')

        endereco.campo('bairro', 'Centro')

        endereco.campo('cep', '111')

        endereco.campo('cidade', 'Mogi')

        endereco.campo('estado', '1')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve cadastrar endereço com número inválido', () => {

        endereco.campo('tipoEndereco', 'ENTREGA')

        endereco.campo('tipoResidencia', 'Casa')

        endereco.campo('tipoLogradouro', 'Rua')

        endereco.campo('logradouro', 'Rua Teste')

        endereco.campo('numero', '@@@')

        endereco.campo('bairro', 'Centro')

        endereco.campo('cep', '08700-000')

        endereco.campo('cidade', 'Mogi')

        endereco.campo('estado', '1')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve cadastrar endereço com cidade vazia', () => {

        endereco.campo('tipoEndereco', 'ENTREGA')

        endereco.campo('tipoResidencia', 'Casa')

        endereco.campo('tipoLogradouro', 'Rua')

        endereco.campo('logradouro', 'Rua Teste')

        endereco.campo('numero', '123')

        endereco.campo('bairro', 'Centro')

        endereco.campo('cep', '08700-000')

        endereco.campo('estado', '1')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve cadastrar endereço com estado não selecionado', () => {

        endereco.campo('tipoEndereco', 'ENTREGA')

        endereco.campo('tipoResidencia', 'Casa')

        endereco.campo('tipoLogradouro', 'Rua')

        endereco.campo('logradouro', 'Rua Teste')

        endereco.campo('numero', '123')

        endereco.campo('bairro', 'Centro')

        endereco.campo('cep', '08700-000')

        endereco.campo('cidade', 'Mogi')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve cadastrar endereço com campos vazios', () => {

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve cadastrar endereço somente com logradouro', () => {

        endereco.campo('logradouro', 'Rua Teste')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve cadastrar endereço somente com CEP', () => {

        endereco.campo('cep', '08700-000')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    /*it('Não deve cadastrar endereço com CEP inválido', () => {

        endereco.campo('tipoEndereco', 'ENTREGA')

        endereco.campo('tipoResidencia', 'Casa')

        endereco.campo('tipoLogradouro', 'Rua')

        endereco.campo('logradouro', 'Rua Teste')

        endereco.campo('numero', '123')

        endereco.campo('bairro', 'Centro')

        endereco.campo('cep', '111')

        endereco.campo('cidade', 'Mogi')

        endereco.campo('estado', '1')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })*/

    /*it('Não deve cadastrar endereço com número inválido', () => {

        endereco.campo('tipoEndereco', 'ENTREGA')

        endereco.campo('tipoResidencia', 'Casa')

        endereco.campo('tipoLogradouro', 'Rua')

        endereco.campo('logradouro', 'Rua Teste')

        endereco.campo('numero', '@@@')

        endereco.campo('bairro', 'Centro')

        endereco.campo('cep', '08700-000')

        endereco.campo('cidade', 'Mogi')

        endereco.campo('estado', '1')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })*/

    it('Não deve cadastrar endereço com cidade vazia', () => {

        endereco.campo('tipoEndereco', 'ENTREGA')

        endereco.campo('tipoResidencia', 'Casa')

        endereco.campo('tipoLogradouro', 'Rua')

        endereco.campo('logradouro', 'Rua Teste')

        endereco.campo('numero', '123')

        endereco.campo('bairro', 'Centro')

        endereco.campo('cep', '08700-000')

        endereco.campo('estado', '1')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve cadastrar endereço com estado não selecionado', () => {

        endereco.campo('tipoEndereco', 'ENTREGA')

        endereco.campo('tipoResidencia', 'Casa')

        endereco.campo('tipoLogradouro', 'Rua')

        endereco.campo('logradouro', 'Rua Teste')

        endereco.campo('numero', '123')

        endereco.campo('bairro', 'Centro')

        endereco.campo('cep', '08700-000')

        endereco.campo('cidade', 'Mogi')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Deve validar página automaticamente', () => {

        endereco.validar()
    })

    it('Deve cadastrar endereço', () => {

        endereco.campo('tipoEndereco', 'ENTREGA')

        endereco.campo('tipoResidencia', 'Casa')

        endereco.campo('tipoLogradouro', 'Rua')

        endereco.campo('logradouro', 'Rua das Flores')

        endereco.campo('numero', '123')

        endereco.campo('bairro', 'Centro')

        endereco.campo('cep', '08700-000')

        endereco.campo('cidade', 'Mogi das Cruzes')

        endereco.campo('estado', '1')

        endereco.campo('observacoes', 'Perto da praça')

        endereco.clicarBotao('salvar')

        cy.contains('Rua das Flores')
            .should('exist')
    })

    it('Não deve editar logradouro vazio', () => {

        endereco.clicarBotao('editar')

        endereco.campo('logradouro', ' ')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve editar número com caracteres inválidos', () => {

        endereco.clicarBotao('editar')

        endereco.campo('numero', '@@@')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve editar CEP inválido', () => {

        endereco.clicarBotao('editar')

        endereco.campo('cep', '123')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve editar bairro vazio', () => {

        endereco.clicarBotao('editar')

        endereco.campo('bairro', ' ')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve editar cidade vazia', () => {

        endereco.clicarBotao('editar')

        endereco.campo('cidade', ' ')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve editar tipo de residência vazio', () => {

        endereco.clicarBotao('editar')

        endereco.campo('tipoResidencia', ' ')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve editar tipo de logradouro vazio', () => {

        endereco.clicarBotao('editar')

        endereco.campo('tipoLogradouro', ' ')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Não deve editar endereço sem estado', () => {

        endereco.clicarBotao('editar')

        cy.get('[data-test="endereco-estado"]')
            .select('')

        endereco.clicarBotao('salvar')

        cy.url()
            .should('include', '/endereco')
    })

    it('Deve editar endereço', () => {

        endereco.clicarBotao('editar')

        endereco.campo('logradouro', 'Rua Editada')

        endereco.campo('cidade', 'cidade Qualquer')

        endereco.campo('estado', '1')

        endereco.clicarBotao('salvar')

        cy.contains('Rua Editada')
            .should('exist')
    })

})