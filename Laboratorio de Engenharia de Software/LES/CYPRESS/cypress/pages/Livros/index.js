import {elements as el} from "./elements"

class Livros {
    buttonVerDetalhesDoLivro(numero){
        cy.get(`${el.detalhesButton}${numero}"]`).click()
    }

    validarAcessoPagina(){
        cy.url().should('eq',el.telaLivros)
    }

}

export default new Livros();