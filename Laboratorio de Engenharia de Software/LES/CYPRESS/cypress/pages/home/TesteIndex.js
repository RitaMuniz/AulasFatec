import { elements as el } from "./TesteElements";

class Home {

    visitarPagina(){
        cy.visit(el.urls.home[0])
    }

    validarAcessoPagina(){
        cy.url().should('be.oneOf', el.urls.home)
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