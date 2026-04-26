import login from "../pages/login";
import home from "../pages/home";

describe( 'Compra',() => {
    it('Adicionar Produto ao carrinho com sucesso ', () => {
        // arrange
        login.visitarPagina()
        login.preencherCredenciaisValidas()
        home.navBarLivros()

        // act
        cy.get('[data-test=menu_livros]').click()
        cy.get('[data-test="btn-ver-detalhes-1"]').click()
        cy.get('[data-test="input-quantidade-1"]').clear().type('55')
        cy.get('[data-test="text-estoque-1"]')
            .invoke('text')
            .then((texto) => {
                const estoque = texto.match(/\d+/)[0] // extrai número

                cy.get('[data-test="input-quantidade-1"]')
                    .should('have.attr', 'max', estoque)
            })


        // assert
    });
})