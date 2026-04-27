import { elements as el } from "./TesteElements";

class Livro {

    validarAcessoPagina(id){
        cy.url().should('eq', `${el.urls.livro}${id}`)
    }

    montarCampoQuantidade(id){
        return `${el.campos.quantidade}${id}${el.sufixoColchete}`
    }

    preencherCampo(campo, id, valor){
        const campos = {
            quantidade: () => {
                cy.get(this.montarCampoQuantidade(id))
                    .clear()
                    .type(valor)
            }
        }

        campos[campo]()
    }

    clicarBotao(botao){
        cy.get(el.botoes[botao]).click()
    }

    validarCampo(campo, id){
        const validacoes = {
            quantidadeInvalida: () => {
                cy.get(this.montarCampoQuantidade(id))
                    .then(el.validarMensagemNavegador)
            }
        }

        validacoes[campo]()
    }

    preencherQuantidade(id, quantidade){
        this.preencherCampo('quantidade', id, quantidade)
    }

    buttonAdicionarAoCarrinho(){
        this.clicarBotao('adicionarCarrinho')
    }

    backButton(){
        this.clicarBotao('voltar')
    }

    validarQuantidadeInvalida(id){
        this.validarCampo('quantidadeInvalida', id)
    }
}

export default new Livro();