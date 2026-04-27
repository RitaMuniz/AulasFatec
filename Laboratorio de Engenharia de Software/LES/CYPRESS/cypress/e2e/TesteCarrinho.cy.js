import home from "../pages/home/TesteIndex";
import livros from "../pages/Livros/TesteIndex";
import livro from "../pages/Livro/TesteIndex";
import carrinho from "../pages/Carrinho/TesteIndex";
import login from "../pages/login/TesteIndex";

describe('Carrinho', () => {

    beforeEach(() => {
        // arrange
        home.visitarPagina()
        home.validarAcessoPagina()
    })


    it('Ir até produto e voltar para o catálogo', () => {
        // act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.clicarBotao('voltar')

        // assert
        livros.validarAcessoPagina()
    })

    it('Adicionar quantidade negativa ao carrinho', () => {
        // act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, -3)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        livro.validarAcessoPagina(1)
        livro.validarCampo('quantidadeInvalida', 1)
    })

    it('Adicionar quantidade zerada ao carrinho', () => {
        // act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 0)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        livro.validarAcessoPagina(1)
        livro.validarCampo('quantidadeInvalida', 1)
    })

    it('Adicionar quantidade acima do estoque ao carrinho', () => {
        // act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 100)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        livro.validarAcessoPagina(1)
        livro.validarCampo('quantidadeInvalida', 1)
    })

    it('Adicionar produto ao carrinho com sucesso', () => {
        // act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 3)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', 1, 3)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Continuar comprando e adicionar item diferente', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 3)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', 2)
        livro.preencherCampo('quantidade', 2, 10)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', 1, 3)
        carrinho.validar('quantidade', 2, 10)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Atualizar item com quantidade maior que estoque', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', 2)
        livro.preencherCampo('quantidade', 2, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.alterarCampo('quantidade', 1, 70)
        carrinho.clicarBotao('atualizar', 1)

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('quantidadeInvalida', 1)
    })

    it('Atualizar item com quantidade zerada', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', 2)
        livro.preencherCampo('quantidade', 2, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.alterarCampo('quantidade', 2, 0)
        carrinho.clicarBotao('atualizar', 2)

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('quantidadeInvalida', 2)
    })

    it('Atualizar item com quantidade negativa', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', 2)
        livro.preencherCampo('quantidade', 2, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.alterarCampo('quantidade', 2, -10)
        carrinho.clicarBotao('atualizar', 2)

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('quantidadeInvalida', 2)
    })

    it('Atualizar item com quantidade válida', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', 2)
        livro.preencherCampo('quantidade', 2, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.alterarCampo('quantidade', 2, 7)
        carrinho.clicarBotao('atualizar', 2)

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', 1, 3)
        carrinho.validar('quantidade', 2, 7)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Remover item do carrinho', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', 2)
        livro.preencherCampo('quantidade', 2, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.clicarBotao('remover', 1)

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', 2, 10)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Adicionar item removido novamente', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', 2)
        livro.preencherCampo('quantidade', 2, 10)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('remover', 1)

        // act
        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 23)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', 1, 23)
        carrinho.validar('quantidade', 2, 10)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Adicionar item já existente acima do estoque', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', 2)
        livro.preencherCampo('quantidade', 2, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 43)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', 1, 44)
        carrinho.validar('quantidade', 2, 10)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Ir para login ao tentar finalizar sem estar logado', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', 1)
        livro.preencherCampo('quantidade', 1, 3)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.clicarBotao('logar')

        // assert
        login.validar('estrutura')
    })

})