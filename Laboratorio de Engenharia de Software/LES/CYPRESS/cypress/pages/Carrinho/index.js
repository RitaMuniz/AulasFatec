import {elements as el} from "./elements";

class carrinho{
    validarAcessoPagina(){
        cy.url().should('eq',el.telaCarrinho)
    }

    validarCampoQuantidade(item,quantidade){
        cy.get(`${el.campoQuantidade}${item}`).should('have.value', quantidade)
    }

    validarCampoQuantidadeInvalida(item){
        cy.get(`${el.campoQuantidade}${item}`).then(($input) => {
            expect($input[0].checkValidity()).to.be.false
        })
    }

    buttonContinuarComprando(){
        cy.get(el.botaoContinuarComprando).click()
    }

    alterarCampoQuantidade(item, quantidade){
        cy.get(`${el.campoQuantidade}${item}`).clear().type(quantidade)
    }

    buttonAtualizar(item){
        cy.get(`${el.botao_atualizar}${item}`).click()
    }

    buttonRemover(item){
        cy.get(`${el.botao_remover}${item}`).click()
    }


}
export default new carrinho()