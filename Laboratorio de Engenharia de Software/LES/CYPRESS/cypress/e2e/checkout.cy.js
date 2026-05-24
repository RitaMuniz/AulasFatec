import home from "../pages/home";
import livros from "../pages/Livros";
import livro from "../pages/Livro";
import carrinho from "../pages/Carrinho";
import login from "../pages/login";

describe('Checkout', () => {

    beforeEach(() => {

        // Login sucesso
        login.visitarPagina()
        login.preencherCredenciaisValidas()
        home.validarAcessoPagina()

        // Monta carrinho para todos os testes
        home.navBarLivros()

        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1, 3)
        livro.buttonAdicionarAoCarrinho()

        carrinho.buttonContinuarComprando()

        livros.buttonVerDetalhesDoLivro(2)
        livro.preencherQuantidade(2, 7)
        livro.buttonAdicionarAoCarrinho()

        carrinho.validarAcessoPagina()
        carrinho.buttonFinalizar()
    })

    it('Deve exibir endereço de entrega', () => {
        cy.get('[data-test="endereco_id"]')
            .should('be.visible')
            .and('not.be.disabled')
    })

    it('selecionar endereço', () => {
        cy.get('[data-test="endereco_id"]')
            .select('8')
    })
})