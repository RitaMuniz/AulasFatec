import { elements as el } from "./TesteElements";

class Home {

    visitarPagina(){
        cy.visit(el.urls.home)
    }

    validarAcessoPagina(){
        cy.url().should('eq', el.urls.home)
    }

    clicarMenu(menu){
        cy.get(el.menus[menu]).click()
    }

    navBarLivros(){
        this.clicarMenu('livros')
    }

    navBarCarrinho(){
        this.clicarMenu('carrinho')
    }
}

export default new Home();