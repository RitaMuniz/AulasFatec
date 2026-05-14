import { elements as el } from "./TesteElements";

class PedidoDetalhe {

    validar(tipo = 'automatico') {
        const validacoes = {
            detalhePedido: () => this.validarEstrutura(),
            statusConfirmado: () => this.validarStatusConfirmado(),
            statusEntregue: () => this.validarStatusEntregue(),
            automatico: () => this.validarAutomatico()
        }

        validacoes[tipo]()
    }

    validarEstrutura() {
        cy.get(el.campos.numeroPedido).should('exist').and('be.visible')
        cy.get(el.campos.totalPedido).should('exist').and('be.visible')
        cy.get(el.status.bar).should('exist').and('be.visible')
    }

    validarStatus(status, ativo = true) {
        cy.get(el.status[status])
            .should(ativo ? 'not.have.class' : 'have.class', 'inactive')
    }


    clicarBotao(botao) {
        cy.get(el.botoes[botao]).click()
    }

    validarAutomatico() {
        this.validarEstrutura()
    }
}

export default new PedidoDetalhe();