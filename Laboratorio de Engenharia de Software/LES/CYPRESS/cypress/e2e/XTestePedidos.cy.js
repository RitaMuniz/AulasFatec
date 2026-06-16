import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import login from "../pages/login/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"

import clientejson from "../fixtures/cliente.json";
import livrosjson from "../fixtures/livro.json";
import enderecojson from "../fixtures/endereco.json";
import cartaojson from "../fixtures/cartao.json";
import cupomjson from "../fixtures/cupom.json";

describe('Fluxo completo de pedido', () => {

    const ENDERECO_VALIDO = enderecojson["dos Bobos"].id
    const CARTAO_MASTERCARD = cartaojson["Odete Roitman Mastercard"].id
    const CARTAO_VISA = cartaojson["Odete Roitman Visa"].id
    const CUPOM_DESCONTO = cupomjson["SUPER_DESCONTO"].id

    beforeEach(() => {
        // arrange
        cy.resetarBanco()

        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()
    })

    afterEach(() => {
        // assert / cleanup
        cy.resetarBanco()
    })

    it('Comprar 1 item com Mastercard', () => {

        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.validar('acessoPagina')
        carrinho.validar('quantidade', livrosjson["1984"].id, 1)

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', ENDERECO_VALIDO)
        checkout.preencherCampo('cartao1', CARTAO_MASTERCARD)
        checkout.preencherValorTotalNoCartao1()
        checkout.clicarBotao('finalizar')

        // assert
        pedidos.validar('confirmacao')
        pedidos.clicarBotao('meusPedidos')
        pedidos.validar('pedidoCadastrado')
        pedidos.clicarBotao('detalhesPedido')
        pedidos.validar('detalhePedido')
        pedidos.validar('statusConfirmado')
    })


    it('Comprar 2 itens com VISA', () => {

        // arrange
        home.clicarMenu('livros')

        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')

        livros.clicarBotao('detalhesLivro', livrosjson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrosjson["Dom Casmurro"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.validar('acessoPagina')
        carrinho.validar('quantidade', livrosjson["1984"].id, 1)
        carrinho.validar('quantidade', livrosjson["Dom Casmurro"].id, 1)

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', ENDERECO_VALIDO)
        checkout.preencherCampo('cartao1', CARTAO_VISA)
        checkout.preencherValorTotalNoCartao1()
        checkout.clicarBotao('finalizar')

        // assert
        pedidos.validar('confirmacao')
        pedidos.clicarBotao('meusPedidos')
        pedidos.validar('pedidoCadastrado')
        pedidos.clicarBotao('detalhesPedido')
        pedidos.validar('detalhePedido')
        pedidos.validar('statusConfirmado')
    })


    it('Não finalizar sem preencher valor do cartão', () => {

        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', ENDERECO_VALIDO)
        checkout.preencherCampo('cartao1', CARTAO_MASTERCARD)
        checkout.limparCampo('valorCartao1')
        checkout.clicarBotao('finalizarForcado')

        // assert
        checkout.validar('cartaoObrigatorio')
    })


    it('Exibir erro quando valor do cartão for menor que o total', () => {

        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', ENDERECO_VALIDO)
        checkout.preencherCampo('cartao1', CARTAO_MASTERCARD)
        checkout.preencherCampo('valorCartao1', '10.00')

        // assert
        checkout.validar('valorCartaoMenorQueTotal')
        checkout.validar('botaoFinalizarDesabilitado')
    })


    it('Exibir erro quando valor do cartão for maior que o total', () => {

        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', ENDERECO_VALIDO)
        checkout.preencherCampo('cartao1', CARTAO_MASTERCARD)
        checkout.preencherCampo('valorCartao1', '9999.00')

        // assert
        checkout.validar('valorCartaoMaiorQueTotal')
        checkout.validar('botaoFinalizarDesabilitado')
    })


    it('Não aceitar valor negativo no cartão', () => {

        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', ENDERECO_VALIDO)
        checkout.preencherCampo('cartao1', CARTAO_MASTERCARD)
        checkout.preencherCampo('valorCartao1', '-10')

        // assert
        checkout.validar('valorCartaoNegativo')
    })


    it('Não aceitar valor zero no cartão', () => {

        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', ENDERECO_VALIDO)
        checkout.preencherCampo('cartao1', CARTAO_MASTERCARD)
        checkout.preencherCampo('valorCartao1', '0')

        // assert
        checkout.validar('valorCartaoZero')
    })


    it('Exibir erro quando soma dos dois cartões for diferente do total', () => {

        // arrange
        home.clicarMenu('livros')

        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')

        livros.clicarBotao('detalhesLivro', livrosjson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrosjson["Dom Casmurro"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', ENDERECO_VALIDO)
        checkout.preencherCampo('cartao1', CARTAO_MASTERCARD)
        checkout.preencherCartoes('10.00', '10.00')

        // assert
        checkout.validar('valorCartaoMenorQueTotal')
        checkout.validar('botaoFinalizarDesabilitado')
    })


    it('Exibir erro quando cartão tiver valor abaixo do mínimo', () => {

        // arrange
        home.clicarMenu('livros')

        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')

        livros.clicarBotao('detalhesLivro', livrosjson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrosjson["Dom Casmurro"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', ENDERECO_VALIDO)
        checkout.preencherCampo('cartao1', CARTAO_MASTERCARD)
        checkout.preencherCartoes('5.00', '50.00')

        // assert
        checkout.validar('valorMinimoCartao')
        checkout.validar('botaoFinalizarDesabilitado')
    })


    it('Aplicar cupom de desconto e validar resumo', () => {

        // arrange
        home.clicarMenu('livros')

        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')

        livros.clicarBotao('detalhesLivro', livrosjson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrosjson["Dom Casmurro"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', ENDERECO_VALIDO)
        checkout.selecionarCupom(CUPOM_DESCONTO)

        // assert
        checkout.validar('cupomAplicado')
        checkout.validar('resumo')
        checkout.validar('total')
    })


    it('Voltar para carrinho pelo checkout', () => {

        // arrange
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.clicarBotao('voltarCarrinho')

        // assert
        carrinho.validar('acessoPagina')
    })

})