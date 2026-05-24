// ==========================================
// ARQUIVO: cypress/pages/AdminTrocas/TesteIndex.js
// ==========================================

import { elements as el } from "./TesteElements"

class AdminTrocas {

    validar(tipo = 'automatico') {

        const validacoes = {

            acessoPagina: () => this.validarAcessoPagina(),

            estrutura: () => this.validarEstrutura(),

            navbar: () => this.validarNavbar(),

            sidebar: () => this.validarSidebar(),

            automatico: () => this.validarAutomatico()
        }

        if(!validacoes[tipo]){
            throw new Error(`Validação "${tipo}" não encontrada`)
        }

        validacoes[tipo]()
    }

    validarAcessoPagina(){

        cy.url()
            .should('match', el.regex.pagina)
    }

    validarEstrutura(){

        cy.get(el.titulo)
            .should('contain.text', 'Devoluções / Trocas')
    }

    validarNavbar(){

        cy.get(el.navbar.loja)
            .should('exist')

        cy.get(el.navbar.sair)
            .should('exist')
    }

    validarSidebar(){

        cy.get(el.sidebar.dashboard)
            .should('exist')

        cy.get(el.sidebar.pedidos)
            .should('exist')

        cy.get(el.sidebar.livros)
            .should('exist')

        cy.get(el.sidebar.clientes)
            .should('exist')

        cy.get(el.sidebar.devolucoes)
            .should('exist')

        cy.get(el.sidebar.relatorio)
            .should('exist')
    }

    validarMensagem(tipo){

        const mensagens = {

            concluida: () => {

                cy.get(el.mensagens.concluida)
                    .should('exist')
            },

            aprovada: () => {

                cy.get(el.mensagens.aprovada)
                    .should('exist')
            },

            recusada: () => {

                cy.get(el.mensagens.recusada)
                    .should('exist')
            },

            sucesso: () => {

                cy.get(el.mensagens.sucesso)
                    .should('exist')
            },

            erro: () => {

                cy.get(el.mensagens.erro)
                    .should('exist')
            },

            nenhumaSolicitacao: () => {

                cy.get(el.mensagens.nenhumaSolicitacao)
                    .should('exist')
            },

            semHistorico: () => {

                cy.get(el.mensagens.semHistorico)
                    .should('exist')
            }
        }

        if(!mensagens[tipo]){
            throw new Error(`Mensagem "${tipo}" não encontrada`)
        }

        mensagens[tipo]()
    }

    clicarBotao(botao, id){

        const botoes = {

            visualizar: () => {

                cy.get(`[data-test="tabela-item-button-visualizar-${id}"]`)
                    .click()
            },

            aprovar: () => {

                cy.get(`[data-test="tabela-item-button-aprovar-${id}"]`)
                    .click()
            },

            recusar: () => {

                cy.get(`[data-test="tabela-item-button-recusar-${id}"]`)
                    .click()
            },

            receber: () => {

                cy.get(`[data-test="tabela-item-button-receber-${id}"]`)
                    .click()
            },

            concluir: () => {

                cy.get(`[data-test="tabela-item-button-concluir-${id}"]`)
                    .click()
            }
        }

        if(!botoes[botao]){
            throw new Error(`Botão "${botao}" não encontrado`)
        }

        botoes[botao]()
    }

    validarStatus(id, status){

        cy.get(`[data-test="tabela-item-status-${status}"]`)
            .should('exist')
    }

    validarAutomatico(){

        this.validarAcessoPagina()

        this.validarEstrutura()

        this.validarNavbar()

        this.validarSidebar()
    }
}

export default new AdminTrocas()