import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import login from "../pages/login/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"

import usuarios from "../fixtures/usuariosTeste.json"
import livrosDados from "../fixtures/livrosTeste.json"
import enderecos from "../fixtures/enderecosTeste.json"
import cartoes from "../fixtures/cartoesTeste.json"
import cupons from "../fixtures/cuponsTeste.json"
import clientejson from "../fixtures/cliente.json";
import livrosjson from "../fixtures/livro.json";
import enderecojson from "../fixtures/endereco.json";
import cartaojson from "../fixtures/cartao.json";
import cupomjson from "../fixtures/cupom.json";

describe('Fluxo completo de pedido', () => {

    beforeEach(() => {
        // arrange
        cy.resetarBanco()
    })

    afterEach(() => {
        // cleanup
        cy.resetarBanco()
    })


    it('Cliente logado compra 1 item com Mastercard', () => {

        // arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.validar('acessoPagina')
        carrinho.validar('quantidade', livrosjson["1984"].id, 1)

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id)
        checkout.validar('cartaoSelecionado', String(cartaojson["Odete Roitman Mastercard"].id))

        checkout.validar('resumo')
        checkout.preencherValorTotalNoCartao1()
        checkout.validar('valorCartao')
        checkout.validar('cartaoBateComResumo')

        checkout.clicarBotao('finalizar')

        // assert
        pedidos.validar('confirmacao')
        pedidos.clicarBotao('meusPedidos')
        pedidos.validar('pedidoCadastrado')
        pedidos.clicarBotao('detalhesPedido')
        pedidos.validar('detalhePedido')
        pedidos.validar('statusConfirmado')
    })


    it('Cliente logado compra 2 itens com VISA/ELO', () => {

        // arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

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
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Visa"].id)
        checkout.validar('cartaoSelecionado', String(cartaojson["Odete Roitman Visa"].id))

        checkout.validar('resumo')
        checkout.preencherValorTotalNoCartao1()
        checkout.validar('valorCartao')
        checkout.validar('cartaoBateComResumo')

        checkout.clicarBotao('finalizar')

        // assert
        pedidos.validar('confirmacao')
        pedidos.clicarBotao('meusPedidos')
        pedidos.validar('pedidoCadastrado')
        pedidos.clicarBotao('detalhesPedido')
        pedidos.validar('detalhePedido')
        pedidos.validar('statusConfirmado')
    })


    it('Cliente deslogado adiciona item, precisa logar e finaliza pedido', () => {

        // arrange
        home.visitarPagina()
        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.validar('acessoPagina')
        carrinho.validar('quantidade', livrosjson["1984"].id, 1)

        // act
        carrinho.clicarBotao('logar')

        login.validar('estrutura')
        login.validar('atributos')

        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('carrinho')
        carrinho.validar('acessoPagina')
        carrinho.validar('quantidade', livrosjson["1984"].id, 1)

        carrinho.clicarBotao('finalizar')

        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id)
        checkout.validar('cartaoSelecionado', String(cartaojson["Odete Roitman Mastercard"].id))

        checkout.validar('resumo')
        checkout.preencherValorTotalNoCartao1()
        checkout.validar('valorCartao')
        checkout.validar('cartaoBateComResumo')

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
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id)
        checkout.limparCampo('valorCartao1')
        checkout.clicarBotao('finalizarForcado')

        // assert
        checkout.validar('cartaoObrigatorio')
    })


    it('Não finalizar com valor do cartão menor que o total', () => {

        // arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id)
        checkout.preencherCampo('valorCartao1', '10.00')

        // assert
        checkout.validar('valorCartaoMenorQueTotal')
        checkout.validar('botaoFinalizarDesabilitado')
    })


    it('Não finalizar com valor do cartão maior que o total', () => {

        // arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id)
        checkout.preencherCampo('valorCartao1', '9999.00')

        // assert
        checkout.validar('valorCartaoMaiorQueTotal')
        checkout.validar('botaoFinalizarDesabilitado')
    })


    it('Não aceitar valor negativo no cartão', () => {

        // arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id)
        checkout.preencherCampo('valorCartao1', '-10')

        // assert
        checkout.validar('valorCartaoNegativo')
    })


    it('Não aceitar valor zero no cartão', () => {

        // arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // act
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id)
        checkout.preencherCampo('valorCartao1', '0')

        // assert
        checkout.validar('valorCartaoZero')
    })


    it('Não finalizar quando soma dos dois cartões for diferente do total', () => {

        // arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

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
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id)
        checkout.preencherCartoes('10.00', '10.00')

        // assert
        checkout.validar('valorCartaoMenorQueTotal')
        checkout.validar('botaoFinalizarDesabilitado')
    })


    it('Não finalizar quando cartão tiver valor abaixo do mínimo', () => {

        // arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

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
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id)
        checkout.preencherCartoes('5.00', '50.00')

        // assert
        checkout.validar('valorMinimoCartao')
        checkout.validar('botaoFinalizarDesabilitado')
    })


    it('Aplicar cupom de desconto e validar resumo', () => {

        // arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')

        home.validarAcessoPagina()

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
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.selecionarCupom(cupomjson["SUPER_DESCONTO"].id)

        // assert
        checkout.validar('cupomAplicado')
        checkout.preencherValorTotalNoCartao1()
        checkout.validar('resumo')
        checkout.validar('total')
        checkout.clicarBotao('finalizar')
        pedidos.validar('confirmacao')
        pedidos.clicarBotao('meusPedidos')
        pedidos.validar('pedidoCadastrado')
        pedidos.clicarBotao('detalhesPedido')
        pedidos.validar('detalhePedido')
        pedidos.validar('statusConfirmado')
    })

})