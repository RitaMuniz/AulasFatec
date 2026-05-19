import { elements as el } from "./TesteElements"

class Cartoes {

    validar(tipo = 'automatico') {

        const validacoes = {

            acessoPagina: () => this.validarAcessoPagina(),

            estrutura: () => this.validarEstrutura(),

            navbar: () => this.validarNavbar(),

            campos: () => this.validarCampos(),

            botoes: () => this.validarBotoes(),

            automatico: () => this.validarAutomatico()
        }

        if(!validacoes[tipo]){
            throw new Error(`Validação "${tipo}" não encontrada`)
        }

        validacoes[tipo]()
    }

    campo(campo, valor){

        const campos = {

            nome: () => {

                cy.get(el.campos.nome)
                    .clear()
                    .type(valor)
            },

            numero: () => {

                cy.get(el.campos.numero)
                    .clear()
                    .type(valor)
            },

            validade: () => {

                cy.get(el.campos.validade)
                    .clear()
                    .type(valor)
            },

            bandeira: () => {

                cy.get(el.campos.bandeira)
                    .select(valor)
            },

            cvv: () => {

                cy.get(el.campos.cvv)
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

            adicionar: () => {

                cy.get(el.botoes.adicionar)
                    .last()
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
            .should('match', el.regex.cartoes)
    }

    validarEstrutura(){

        cy.get(el.titulo)
            .should('contain.text', 'Gerenciar Cartões')
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

        cy.get(el.campos.nome)
            .should('exist')

        cy.get(el.campos.numero)
            .should('exist')

        cy.get(el.campos.validade)
            .should('exist')

        cy.get(el.campos.bandeira)
            .should('exist')

        cy.get(el.campos.cvv)
            .should('exist')
    }

    validarBotoes(){

        cy.get(el.botoes.adicionar)
            .should('exist')

        cy.get(el.botoes.excluir)
            .should('exist')
    }

    validarAutomatico(){

        this.validarAcessoPagina()

        this.validarEstrutura()

        this.validarNavbar()

        this.validarCampos()

        this.validarBotoes()
    }
}

export default new Cartoes()