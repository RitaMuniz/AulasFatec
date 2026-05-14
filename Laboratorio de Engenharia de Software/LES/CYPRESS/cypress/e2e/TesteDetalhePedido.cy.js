import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import login from "../pages/login/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"
import pedidoDetalhe from "../pages/Pedido/TesteIndex"

import usuarios from "../fixtures/usuarios.json"
import livrosDados from "../fixtures/livros.json"
import enderecos from "../fixtures/enderecos.json"
import cartoes from "../fixtures/cartoes.json"
import cupons from "../fixtures/cupons.json"

describe('Fluxo completo de pedido', () => {

    beforeEach(() => {
        // arrange
        cy.resetarBanco()




    })

    afterEach(() => {
        // cleanup
        cy.resetarBanco()
    })

    it('Teste', () => {
        login.visitarPagina()
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')


        home.validarAcessoPagina()
        home.clicarMenu('livros')

        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')

        livros.clicarBotao('detalhesLivro', livrosDados.livro2.id)
        livro.preencherCampo('quantidade', livrosDados.livro2.id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.validar('acessoPagina')
        carrinho.validar('quantidade', livrosDados.livro1.id, 1)
        carrinho.clicarBotao('finalizar')

        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecos.maria.entrega)
        checkout.preencherCampo('cartao1', cartoes.maria.elo.id)
        checkout.preencherCartoes('10.17', '26.96')
        checkout.preencherCampo('selectCartao2', cartoes.maria.mastercard.id)
        checkout.selecionarCupom(cupons.maria["20"].id)
        checkout.validar('cupomAplicado')
        checkout.validar('resumo')
        checkout.validar('total')
        checkout.clicarBotao('finalizar')


        pedidos.validar('confirmacao')
        pedidos.clicarBotao('meusPedidos')
        pedidos.validar('pedidoCadastrado')
        pedidos.clicarBotao('detalhesPedido')
        pedidos.validar('detalhePedido')
        pedidos.validar('statusConfirmado')

        pedidoDetalhe.validarStatus('confirmado', true)
        pedidoDetalhe.validarStatus('separando', false)
        pedidoDetalhe.validarStatus('enviado', false)
        pedidoDetalhe.validarStatus('entregue', false)
        pedidoDetalhe.validar('detalhePedido')
        pedidoDetalhe.validar()
        pedidoDetalhe.clicarBotao('voltar')

        pedidos.clicarBotao('sair')

        login.visitarPagina()
        login.preencherCampo('username', usuarios.admin.email)
        login.preencherCampo('password', usuarios.admin.senha)
        login.clicarBotao('entrar')


    })

})