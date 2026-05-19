// ==========================================
// ARQUIVO: cypress/pages/AdminEditarPedido/TesteIndex.js
// ==========================================

import { elements as el } from "./TesteElements"

class EditarPedidoAdmin {

    validar(tipo = 'automatico') {

        const validacoes = {

            estrutura: () => this.validarEstrutura(),

            acessoPagina: () => this.validarAcessoPagina(),

            cliente: () => this.validarCliente(),

            status: () => this.validarStatus(),

            itens: () => this.validarItens(),

            total: () => this.validarTotal(),

            sidebar: () => this.validarSidebar(),

            automatico: () => this.validarAutomatico()
        }

        if (!validacoes[tipo]) {
            throw new Error(`Validação "${tipo}" não existe`)
        }

        validacoes[tipo]()
    }

    campo(campo, valor) {

        const campos = {

            status: () => {

                cy.get(el.form.status)
                    .select(valor)
            }
        }

        if (!campos[campo]) {
            throw new Error(`Campo "${campo}" não encontrado`)
        }

        campos[campo]()
    }

    validarCampo(campo, valor) {

        const campos = {

            status: () => {

                cy.get(el.form.status)
                    .should('have.value', valor)
            }
        }

        if (!campos[campo]) {
            throw new Error(`Campo "${campo}" não encontrado`)
        }

        campos[campo]()
    }

    clicarBotao(botao) {

        const botoes = {

            salvar: () => {

                cy.get(el.botoes.salvar)
                    .click()
            },

            cancelar: () => {

                cy.get(el.botoes.cancelar)
                    .click()
            },

            dashboard: () => {

                cy.get(el.sidebar.dashboard)
                    .click()
            },

            pedidos: () => {

                cy.get(el.sidebar.pedidos)
                    .click()
            },

            livros: () => {

                cy.get(el.sidebar.livros)
                    .click()
            },

            clientes: () => {

                cy.get(el.sidebar.clientes)
                    .click()
            },

            devolucoes: () => {

                cy.get(el.sidebar.devolucoes)
                    .click()
            },

            relatorio: () => {

                cy.get(el.sidebar.relatorio)
                    .click()
            }
        }

        if (!botoes[botao]) {
            throw new Error(`Botão "${botao}" não encontrado`)
        }

        botoes[botao]()
    }

    validarEstrutura() {

        cy.get(el.topbar.titulo)
            .should('exist')
            .and('contain.text', 'Editar Pedido')

        cy.get(el.botoes.salvar)
            .should('exist')

        cy.get(el.botoes.cancelar)
            .should('exist')
    }

    validarAcessoPagina() {

        cy.url()
            .should('match', el.regex.editarPedido)
    }

    validarCliente() {

        cy.get(el.cliente.nome)
            .should('exist')

        cy.get(el.cliente.email)
            .should('exist')

        cy.get(el.cliente.cpf)
            .should('exist')
    }

    validarStatus() {

        cy.get(el.form.status)
            .should('exist')
    }

    validarItens() {

        cy.get(el.itens.titulo)
            .should('have.length.at.least', 1)

        cy.get(el.itens.quantidade)
            .should('exist')

        cy.get(el.itens.precoUnitario)
            .should('exist')

        cy.get(el.itens.subtotal)
            .should('exist')
    }

    validarStatusDetalhe(status){

        cy.get(`[data-test="pedido-numero-${status}"]`)
            .should('exist')
            .and('contain.text', status)
    }

    validarTotal() {

        cy.get(el.total)
            .should('exist')
            .and('contain.text', 'R$')
    }

    validarSidebar() {

        cy.get(el.sidebar.dashboard)
            .should('exist')

        cy.get(el.sidebar.pedidos)
            .should('have.class', 'active')

        cy.get(el.sidebar.livros)
            .should('exist')

        cy.get(el.sidebar.clientes)
            .should('exist')

        cy.get(el.sidebar.devolucoes)
            .should('exist')

        cy.get(el.sidebar.relatorio)
            .should('exist')
    }

    validarAutomatico() {

        this.validarEstrutura()

        this.validarAcessoPagina()

        this.validarCliente()

        this.validarStatus()

        this.validarItens()

        this.validarTotal()

        this.validarSidebar()
    }
}

export default new EditarPedidoAdmin()