// ==========================================
// ARQUIVO: cypress/pages/ClienteTrocas/TesteIndex.js
// ==========================================

import { elements as el } from "./TesteElements"

class ClienteTrocas {

    visitarPagina() {
        cy.visit('/troca') // Ajuste o caminho se necessário de acordo com a baseUrl
    }

    validar(tipo = 'automatico') {
        const validacoes = {
            acessoPagina: () => this.validarAcessoPagina(),
            estrutura: () => this.validarEstrutura(),
            navbar: () => this.validarNavbar(),
            automatico: () => this.validarAutomatico()
        }

        if (!validacoes[tipo]) {
            throw new Error(`Validação "${tipo}" não encontrada em ClienteTrocas`)
        }

        validacoes[tipo]()
    }

    validarAcessoPagina() {
        cy.url().should('match', el.regex.pagina)
    }

    validarEstrutura() {
        cy.get(el.titulo).should('contain.text', 'Minhas Trocas')
    }

    validarNavbar() {
        cy.get(el.navbar.inicio).should('exist')
        cy.get(el.navbar.meusPedidos).should('exist')
        cy.get(el.navbar.minhasTrocas).should('exist')
    }

    validarMensagem(tipo) {
        const mensagens = {
            sucesso: () => {
                cy.get(el.mensagens.sucesso)
                    .should('exist')
                    .and('contain.text', 'Solicitação de troca enviada com sucesso!')
            },
            nenhumaSolicitacao: () => {
                cy.get(el.mensagens.nenhumaSolicitacao)
                    .should('exist')
                    .and('contain.text', 'Você não possui solicitações de troca.')
            }
        }

        if (!mensagens[tipo]) {
            throw new Error(`Mensagem "${tipo}" não encontrada em ClienteTrocas`)
        }

        mensagens[tipo]()
    }

    clicarBotao(botao) {
        const botoes = {
            voltarMeusPedidos: () => {
                cy.get(el.botoes.voltarMeusPedidos).click()
            },

            inicio: () => {
                cy.get(el.botoes.inicio).click()
            }
        }

        if (!botoes[botao]) {
            throw new Error(`Botão "${botao}" não encontrado em ClienteTrocas`)
        }

        botoes[botao]()
    }

    // Valida uma linha específica da tabela baseado nas variáveis dinâmicas do JSP
    validarItemTabela(dadosTroca) {
        // Formato das chaves baseadas no seu JSP: data-test="tabela-item-${trocas}-id-${t.id}"
        // Nota: Como '${trocas}' renderiza o objeto/lista no JSP, assume-se comportamento de String ou ID correspondente.
        // Caso no seu HTML renderizado apareça algo fixo ou omitido, ajuste o prefixo da string abaixo.

        cy.get(`td[data-test*="-id-${dadosTroca.id}"]`)
            .as('linhaId')
            .should('contain.text', dadosTroca.id)

        // A partir do seletor flexível, valida os nós irmãos ou correspondentes daquela linha
        cy.get(`td[data-test*="-pedido-${dadosTroca.pedidoId}"]`).should('contain.text', `#${dadosTroca.pedidoId}`)
        cy.get(`td[data-test*="-dataSolicitacao-${dadosTroca.dataSolicitacao}"]`).should('contain.text', dadosTroca.dataSolicitacao)
        cy.get(`td[data-test*="-status-${dadosTroca.status}"]`).should('contain.text', dadosTroca.status)

        // Trata os campos opcionais / condicionais do JSP
        cy.get(`td[data-test*="-dataRecebimento-"]`).contains(dadosTroca.dataRecebimento).should('exist')
        cy.get(`td[data-test*="-cupom-"]`).contains(dadosTroca.cupomGerado).should('exist')


        if (dadosTroca.dataRecebimento) {
            cy.get(`[data-test*="-dataRecebimento-${dadosTroca.dataRecebimento}"]`).should('contain.text', dadosTroca.dataRecebimento)
        }

        if (dadosTroca.cupomGeradoId) {
            cy.get(`[data-test*="-cupom-"]`).should('contain.text', dadosTroca.cupomGeradoId)
        }
    }

    validarAutomatico() {
        this.validarAcessoPagina()
        this.validarEstrutura()
        this.validarNavbar()
    }
}

export default new ClienteTrocas()