import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import login from "../pages/login/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"
import pedidoDetalhe from "../pages/Pedido/TesteIndex"
import adminDashboard from "../pages/AdminDashboard/TesteIndex"

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

    it('Pagina detalhe pedido', () => {
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
        carrinho.clicarBotao('finalizar')

        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Visa"].id)
        checkout.preencherCartoes('10.17', '26.96')
        checkout.preencherCampo('selectCartao2', cartaojson["Odete Roitman Mastercard"].id)
        checkout.selecionarCupom(cupomjson["SUPER_DESCONTO"].id)
        checkout.preencherValor('cartao2')
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

        adminDashboard.validarAcessoPagina()
        adminDashboard.validarDashboard()
        adminDashboard.clicarBotao("pedidos")


    })

})