import { elements as el } from "./elements";

class Checkout {

    preencherValorTotalNoCartao1() {
        cy.get('[data-test="resumo-total"]')
            .should('not.contain', '—')
            .invoke('text')
            .then((totalTexto) => {

                const total = totalTexto
                    .replace('R$', '')
                    .replace('.', '')
                    .replace(',', '.')
                    .trim()

                cy.get('[data-test="input-valor-cartao-1"]')
                    .clear()
                    .type(total)
                    .trigger('input')
                    .trigger('change')
            })

    }

    buttonFinalizar() {
        cy.get('[data-test="botao_finalizar"]')
            .invoke('removeAttr', 'disabled')
            .click()
    }
}

export default new Checkout()