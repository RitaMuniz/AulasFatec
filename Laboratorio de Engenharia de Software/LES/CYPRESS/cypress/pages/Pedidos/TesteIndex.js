import { elements as el } from "./TesteElements";

class Pedidos {

    validar(tipo = 'automatico'){
        const validacoes = {
            confirmacao: () => this.validarConfirmacao(),
            pedidos: () => this.validarPedidos(),
            pedidoCadastrado: () => this.validarPedidoCadastrado(),
            detalhePedido: () => this.validarDetalhePedido(),
            statusConfirmado: () => this.validarStatusConfirmado(),
            automatico: () => this.validarAutomatico()
        }

        if(!validacoes[tipo]){
            throw new Error(`Validação "${tipo}" não existe em Pedidos/TesteIndex.js`)
        }

        validacoes[tipo]()
    }

    clicarBotao(botao){
        cy.get(el.botoes[botao])
            .first()
            .click()
    }

    validarConfirmacao(){
        cy.url()
            .should('include', el.urls.confirmacao)
    }

    validarPedidos(){
        cy.url()
            .should('include', el.urls.pedidos)
    }

    validarPedidoCadastrado(){
        this.validarPedidos()

        cy.get(el.textos.pedidoNumero)
            .first()
            .should('exist')
            .and('contain.text', 'Pedido #')

        cy.get(el.textos.pedidoTotal)
            .first()
            .should('exist')
            .and('contain.text', 'R$')

        cy.get(el.textos.pedidoStatus)
            .first()
            .should('exist')
    }

    validarDetalhePedido(){
        cy.get(el.textos.detalhePedidoNumero)
            .should('exist')
            .and('contain.text', 'Pedido #')

        cy.get(el.textos.detalhePedidoTotal)
            .should('exist')
            .and('contain.text', 'R$')

        cy.get(el.textos.statusBar)
            .should('exist')
    }

    validarStatusConfirmado(){
        cy.get(el.textos.statusConfirmado)
            .should('exist')
            .and('not.have.class', 'inactive')
    }

    validarAutomatico(){
        cy.url().then(url => {
            if(url.includes(el.urls.confirmacao)){
                this.validarConfirmacao()
                return
            }

            if(url.includes(el.urls.pedidos)){
                this.validarPedidoCadastrado()
                return
            }

            throw new Error('Página atual não é confirmação nem pedidos')
        })
    }
}

export default new Pedidos()