import { elements as el } from "./TesteElements";

class Livros {

    validarAcessoPagina(){
        cy.url().should('eq', el.urls.livros)
    }

    montarSeletorComId(seletorBase, id){
        return `${seletorBase}${id}${el.sufixoDataTest}`
    }

    clicarBotao(botao, id){
        cy.get(
            this.montarSeletorComId(el.botoes[botao], id)
        ).click()
    }

    buttonVerDetalhesDoLivro(id){
        this.clicarBotao('detalhesLivro', id)
    }
}

export default new Livros();