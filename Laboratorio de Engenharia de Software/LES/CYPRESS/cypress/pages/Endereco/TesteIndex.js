import { elements as el } from "./TesteElements"

class Endereco {

    validar(tipo = 'automatico'){

        const validacoes = {

            acessoPagina: () => this.validarAcessoPagina(),

            estrutura: () => this.validarEstrutura(),

            navbar: () => this.validarNavbar(),

            campos: () => this.validarCampos(),

            botoes: () => this.validarBotoes(),

            tabela: () => this.validarTabela(),

            automatico: () => this.validarAutomatico()
        }

        if(!validacoes[tipo]){
            throw new Error(`Validação "${tipo}" não encontrada`)
        }

        validacoes[tipo]()
    }

    campo(campo, valor){

        const campos = {

            tipoEndereco: () => {
                cy.get(el.campos.tipoEndereco)
                    .select(valor)
            },

            tipoResidencia: () => {
                cy.get(el.campos.tipoResidencia)
                    .clear()
                    .type(valor)
            },

            tipoLogradouro: () => {
                cy.get(el.campos.tipoLogradouro)
                    .clear()
                    .type(valor)
            },

            logradouro: () => {
                cy.get(el.campos.logradouro)
                    .clear()
                    .type(valor)
            },

            numero: () => {
                cy.get(el.campos.numero)
                    .clear()
                    .type(valor)
            },

            bairro: () => {
                cy.get(el.campos.bairro)
                    .clear()
                    .type(valor)
            },

            cep: () => {
                cy.get(el.campos.cep)
                    .clear()
                    .type(valor)
            },

            cidade: () => {
                cy.get(el.campos.cidade)
                    .clear()
                    .type(valor)
            },

            estado: () => {
                cy.get(el.campos.estado)
                    .select(valor)
            },

            observacoes: () => {
                cy.get(el.campos.observacoes)
                    .clear()
                    .type(valor)
            }
        }

        if(!campos[campo]){
            throw new Error(`Campo "${campo}" não encontrado`)
        }

        campos[campo]()
    }

    clicarBotao(botao){

        const botoes = {

            salvar: () => {
                cy.get(el.botoes.salvar)
                    .click()
            },

            cancelar: () => {
                cy.get(el.botoes.cancelar)
                    .click()
            },

            editar: () => {
                cy.get(el.botoes.editar)
                    .first()
                    .click()
            },

            excluir: () => {
                cy.get(el.botoes.excluir)
                    .first()
                    .click()
            }
        }

        if(!botoes[botao]){
            throw new Error(`Botão "${botao}" não encontrado`)
        }

        botoes[botao]()
    }

    validarAcessoPagina(){

        cy.url()
            .should('match', el.regex.endereco)
    }

    validarEstrutura(){

        cy.get(el.titulo)
            .should('contain.text', 'Gerenciar Endereços')
    }

    validarNavbar(){

        cy.get(el.navbar.home)
            .should('exist')

        cy.get(el.navbar.perfil)
            .should('exist')

        cy.get(el.navbar.sair)
            .should('exist')
    }

    validarCampos(){

        cy.get(el.campos.tipoEndereco)
            .should('exist')

        cy.get(el.campos.tipoResidencia)
            .should('exist')

        cy.get(el.campos.tipoLogradouro)
            .should('exist')

        cy.get(el.campos.logradouro)
            .should('exist')

        cy.get(el.campos.numero)
            .should('exist')

        cy.get(el.campos.bairro)
            .should('exist')

        cy.get(el.campos.cep)
            .should('exist')

        cy.get(el.campos.cidade)
            .should('exist')

        cy.get(el.campos.estado)
            .should('exist')

        cy.get(el.campos.observacoes)
            .should('exist')
    }

    validarBotoes(){

        cy.get(el.botoes.salvar)
            .should('exist')

        cy.get(el.botoes.cancelar)
            .should('exist')
    }

    validarTabela(){

        cy.get('table')
            .should('exist')
    }

    validarAutomatico(){

        this.validarAcessoPagina()

        this.validarEstrutura()

        this.validarNavbar()

        this.validarCampos()

        this.validarBotoes()

        this.validarTabela()
    }
}

export default new Endereco()