import {elements as el} from "./elements";
class Livro{
    preencherQuantidade(numero, quantidade){
        cy.get(`${el.inputQuantidade}${numero}]`)
            .clear()
            .type(quantidade)
    }

    backButton(){
        cy.get(el.botao_voltar).click()
    }

    buttonAdicionarAoCarrinho(){
        cy.get(el.adicionarAoCarrinho).click()
    }

    validarAcessoPagina(numero){
        cy.url().should('eq',`${el.telaLivro}${numero}`)
    }

    validarQuantidadeInvalida(numero){
        cy.get(`${el.inputQuantidade}${numero}]`)
            .then(($input) => {
                expect($input[0].checkValidity()).to.be.false
            })
    }

}
export default new Livro()