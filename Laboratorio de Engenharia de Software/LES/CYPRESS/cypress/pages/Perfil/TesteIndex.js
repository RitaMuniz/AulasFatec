import { elements as el } from "./TesteElements"

class Perfil {

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

            genero: () => {

                cy.get(el.campos.genero)
                    .select(valor)
            },

            email: () => {

                cy.get(el.campos.email)
                    .clear()
                    .type(valor)
            },

            dataNascimento: () => {

                cy.get(el.campos.dataNascimento)
                    .clear()
                    .type(valor)
            }
        }

        if(!campos[campo]){
            throw new Error(`Campo "${campo}" não encontrado`)
        }

        campos[campo]()
    }

    validarCampo(campo, valor){

        const campos = {

            nome: () => {

                cy.get(el.campos.nome)
                    .should('have.value', valor)
            },

            genero: () => {

                cy.get(el.campos.genero)
                    .should('have.value', valor)
            },

            email: () => {

                cy.get(el.campos.email)
                    .should('have.value', valor)
            },

            dataNascimento: () => {

                cy.get(el.campos.dataNascimento)
                    .should('have.value', valor)
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

            desativar: () => {

                cy.get(el.botoes.desativar)
                    .click()
            },

            endereco: () => {

                cy.get(el.botoes.endereco)
                    .click()
            },

            cartoes: () => {

                cy.get(el.botoes.cartoes)
                    .click()
            },

            pedidos: () => {

                cy.get(el.botoes.pedidos)
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
            .should('match', el.regex.perfil)
    }

    validarEstrutura(){

        cy.get(el.titulo)
            .should('contain.text', 'Meu Perfil')
    }

    validarNavbar(){

        cy.get(el.navbar.home)
            .should('exist')

        cy.get(el.navbar.livros)
            .should('exist')

        cy.get(el.navbar.carrinho)
            .should('exist')

        cy.get(el.navbar.sair)
            .should('exist')
    }

    validarCampos(){

        cy.get(el.campos.nome)
            .should('exist')

        cy.get(el.campos.genero)
            .should('exist')

        cy.get(el.campos.dataNascimento)
            .should('exist')

        cy.get(el.campos.email)
            .should('exist')
    }

    validarBotoes(){

        cy.get(el.botoes.salvar)
            .should('exist')

        cy.get(el.botoes.desativar)
            .should('exist')

        cy.get(el.botoes.endereco)
            .should('exist')

        cy.get(el.botoes.cartoes)
            .should('exist')

        cy.get(el.botoes.pedidos)
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

export default new Perfil()