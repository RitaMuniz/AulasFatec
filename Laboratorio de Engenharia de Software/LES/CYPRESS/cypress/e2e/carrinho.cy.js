import home from "../pages/home";
import livros from "../pages/Livros";
import livro from "../pages/Livro";
import carrinho from "../pages/Carrinho";

describe('Carrinho', () => {

    beforeEach(() => {
        // arrange
        home.visitarPagina()
    })

    // Ir até o produto e voltar
    it('ir até o produto e voltar carrinho', () => {


        // act
        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.backButton()

        // assert
        livros.validarAcessoPagina()
    });


    // Carrinho com quantidade negativa
    it('Adicionar quantidade negativa ao carrinho', () => {


        // act
        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,-3)
        livro.buttonAdicionarAoCarrinho()

        // assert

        livro.validarAcessoPagina(1)
        livro.validarQuantidadeInvalida(1)
    });

    // Carrinho com quantidade 0
    it('Adicionar quantidade zerada ao carrinho', () => {

        // act
        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,0)
        livro.buttonAdicionarAoCarrinho()

        // assert
        livro.validarAcessoPagina(1)
        livro.validarQuantidadeInvalida(1)
    });

    // Carrinho com quantidade acima do estoque
    it('Adicionar quantidade acima do estoque ao carrinho', () => {


        // act
        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,100)
        livro.buttonAdicionarAoCarrinho()

        // assert
        livro.validarAcessoPagina(1)
        livro.validarQuantidadeInvalida(1)
    });


    // Carrinho feito com sucesso
    it('Adicionar Produto ao carrinho com sucesso ', () => {


        // act
        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,3)
        livro.buttonAdicionarAoCarrinho()

        // assert

        carrinho.validarAcessoPagina()
        carrinho.validarCampoQuantidade(1,3)
    });

    // Adicionando itens diferentes do carrinho
    it('Continuando comprando item diferente', () => {
        // arrange

        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,3)
        livro.buttonAdicionarAoCarrinho()

        // act

        carrinho.buttonContinuarComprando()
        livros.buttonVerDetalhesDoLivro(2)
        livro.preencherQuantidade(2,10)
        livro.buttonAdicionarAoCarrinho()
        // assert

        carrinho.validarAcessoPagina()
        carrinho.validarCampoQuantidade(1,3)
        carrinho.validarCampoQuantidade(2,10)
    });

    // Atualizando itens do carrinho quantidade maior que o estoque
    it('Atualizar item com quantidade maior que estoque', () => {
        // arrange

        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,3)
        livro.buttonAdicionarAoCarrinho()
        carrinho.buttonContinuarComprando()
        livros.buttonVerDetalhesDoLivro(2)
        livro.preencherQuantidade(2,10)
        livro.buttonAdicionarAoCarrinho()

        // act

        carrinho.alterarCampoQuantidade(1,70)
        carrinho.buttonAtualizar(1)

        // assert
        carrinho.validarAcessoPagina()


        carrinho.validarCampoQuantidadeInvalida(1)
    });

    // Atualizando itens do carrinho quantidade zerada
    it('Atualizar item com quantidade zerada', () => {
        // arrange

        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,3)
        livro.buttonAdicionarAoCarrinho()
        carrinho.buttonContinuarComprando()
        livros.buttonVerDetalhesDoLivro(2)
        livro.preencherQuantidade(2,10)
        livro.buttonAdicionarAoCarrinho()

        // act
        carrinho.alterarCampoQuantidade(2,0)
        carrinho.buttonAtualizar(2)

        // assert
        carrinho.validarAcessoPagina()
        carrinho.validarCampoQuantidadeInvalida(2)
    });

    // Atualizando itens do carrinho quantidade zerada
    it('Atualizar item com quantidade negativa', () => {
        // arrange

        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,3)
        livro.buttonAdicionarAoCarrinho()
        carrinho.buttonContinuarComprando()
        livros.buttonVerDetalhesDoLivro(2)
        livro.preencherQuantidade(2,10)
        livro.buttonAdicionarAoCarrinho()

        // act
        carrinho.alterarCampoQuantidade(2,-10)
        carrinho.buttonAtualizar(2)

        // assert
        carrinho.validarAcessoPagina()
        carrinho.validarCampoQuantidadeInvalida(2)
    });

    // Atualizando itens do carrinho quantidade certa
    it('Atualizar item com quantidade certa', () => {
        // arrange

        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,3)
        livro.buttonAdicionarAoCarrinho()
        carrinho.buttonContinuarComprando()
        livros.buttonVerDetalhesDoLivro(2)
        livro.preencherQuantidade(2,10)
        livro.buttonAdicionarAoCarrinho()

        // act
        carrinho.alterarCampoQuantidade(2,7)
        carrinho.buttonAtualizar(2)

        // assert
        carrinho.validarAcessoPagina()
        carrinho.validarCampoQuantidade(1,3)
        carrinho.validarCampoQuantidade(2,7)
    });

    // Remover item do carrinho
    it('Remover item do carrinho', () => {
        // arrange

        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,3)
        livro.buttonAdicionarAoCarrinho()
        carrinho.buttonContinuarComprando()
        livros.buttonVerDetalhesDoLivro(2)
        livro.preencherQuantidade(2,10)
        livro.buttonAdicionarAoCarrinho()

        // act

        carrinho.buttonRemover(1)


        // assert
        carrinho.validarAcessoPagina()
        carrinho.validarCampoQuantidade(2,10)
    });

    // Adicionando item removido do carrinho
    it('Adicionar item removido', () => {
        // arrange

        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,3)
        livro.buttonAdicionarAoCarrinho()
        carrinho.buttonContinuarComprando()
        livros.buttonVerDetalhesDoLivro(2)
        livro.preencherQuantidade(2,10)
        livro.buttonAdicionarAoCarrinho()
        carrinho.buttonRemover(1)
        // act
        carrinho.buttonContinuarComprando()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,23)
        livro.buttonAdicionarAoCarrinho()

        // assert
        carrinho.validarAcessoPagina()
        carrinho.validarCampoQuantidade(1,23)
        carrinho.validarCampoQuantidade(2,10)
    });


    // Adicionando item ja existente do carrinho acima do estoque
    it('Adicionar item ja existente acima do estoque', () => {
        // arrange

        home.navBarLivros()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,3)
        livro.buttonAdicionarAoCarrinho()
        carrinho.buttonContinuarComprando()
        livros.buttonVerDetalhesDoLivro(2)
        livro.preencherQuantidade(2,10)
        livro.buttonAdicionarAoCarrinho()

        // act
        carrinho.buttonContinuarComprando()
        livros.buttonVerDetalhesDoLivro(1)
        livro.preencherQuantidade(1,43)
        livro.buttonAdicionarAoCarrinho()

        // assert
        carrinho.validarAcessoPagina()
        carrinho.validarCampoQuantidade(1,44)
        carrinho.validarCampoQuantidade(2,10)
    });



})