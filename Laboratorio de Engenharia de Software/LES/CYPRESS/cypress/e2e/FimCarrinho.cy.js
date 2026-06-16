import home from "../pages/home/TesteIndex";
import livros from "../pages/Livros/TesteIndex";
import livro from "../pages/Livro/TesteIndex";
import carrinho from "../pages/Carrinho/TesteIndex";
import login from "../pages/login/TesteIndex";

import livrojson from "../fixtures/livro.json";
import estoquejson from "../fixtures/estoque.json";

describe('Carrinho', () => {

    beforeEach(() => {
        // arrange
        home.visitarPagina()
        home.validarAcessoPagina()
    })


    it('Ir até produto e voltar para o catálogo', () => {
        // act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.clicarBotao('voltar')

        // assert
        livros.validarAcessoPagina()
    })

    it('Adicionar quantidade negativa ao carrinho', () => {
        // act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, -3)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        livro.validarAcessoPagina(livrojson["1984"].id)
        livro.validarCampo('quantidadeInvalida', livrojson["1984"].id)
    })

    it('Adicionar quantidade zerada ao carrinho', () => {
        // act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 0)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        livro.validarAcessoPagina(livrojson["1984"].id)
        livro.validarCampo('quantidadeInvalida', livrojson["1984"].id)
    })

    it('Adicionar quantidade acima do estoque ao carrinho', () => {
        // act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 100)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        livro.validarAcessoPagina(livrojson["1984"].id)
        livro.validarCampo('quantidadeInvalida', livrojson["1984"].id)
    })

    it('Adicionar produto ao carrinho com sucesso', () => {
        // act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 3)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', livrojson["1984"].id, 3)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Continuar comprando e adicionar item diferente', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 3)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrojson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrojson["Dom Casmurro"].id, 10)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', livrojson["1984"].id, 3)
        carrinho.validar('quantidade', livrojson["Dom Casmurro"].id, 10)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Atualizar item com quantidade maior que estoque', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrojson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrojson["Dom Casmurro"].id, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.alterarCampo('quantidade', livrojson["1984"].id, Number(estoquejson["1984"].quantidade)+1)
        carrinho.clicarBotao('atualizar', livrojson["1984"].id)

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('quantidadeInvalida', livrojson["1984"].id)
    })

    it('Atualizar item com quantidade zerada', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrojson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrojson["Dom Casmurro"].id, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.alterarCampo('quantidade', livrojson["Dom Casmurro"].id, 0)
        carrinho.clicarBotao('atualizar', livrojson["Dom Casmurro"].id)

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('quantidadeInvalida', livrojson["Dom Casmurro"].id)
    })

    it('Atualizar item com quantidade negativa', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrojson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrojson["Dom Casmurro"].id, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.alterarCampo('quantidade', livrojson["Dom Casmurro"].id, -10)
        carrinho.clicarBotao('atualizar', livrojson["Dom Casmurro"].id)

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('quantidadeInvalida', livrojson["Dom Casmurro"].id)
    })

    it('Atualizar item com quantidade válida', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrojson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrojson["Dom Casmurro"].id, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.alterarCampo('quantidade', livrojson["Dom Casmurro"].id, 7)
        carrinho.clicarBotao('atualizar', livrojson["Dom Casmurro"].id)

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', livrojson["1984"].id, 3)
        carrinho.validar('quantidade', livrojson["Dom Casmurro"].id, 7)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Remover item do carrinho', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrojson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrojson["Dom Casmurro"].id, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.clicarBotao('remover', livrojson["1984"].id)

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', livrojson["Dom Casmurro"].id, 10)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Adicionar item removido novamente', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrojson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrojson["Dom Casmurro"].id, 10)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('remover', livrojson["1984"].id)

        // act
        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 23)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', livrojson["1984"].id, 23)
        carrinho.validar('quantidade', livrojson["Dom Casmurro"].id, 10)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')
    })

    it('Adicionar item já existente acima do estoque', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 3)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrojson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrojson["Dom Casmurro"].id, 10)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 43)
        livro.clicarBotao('adicionarCarrinho')

        // assert
        /*carrinho.validar('acessoPagina')
        carrinho.validar('estrutura')
        carrinho.validar('quantidade', 1, 44)
        carrinho.validar('quantidade', 2, 10)
        carrinho.validar('resumo')
        carrinho.validar('totalEstimado')*/
    })

    it('Ir para login ao tentar finalizar sem estar logado', () => {
        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrojson["1984"].id)
        livro.preencherCampo('quantidade', livrojson["1984"].id, 3)
        livro.clicarBotao('adicionarCarrinho')

        // act
        carrinho.clicarBotao('logar')

        // assert
        login.validar('estrutura')
    })

})