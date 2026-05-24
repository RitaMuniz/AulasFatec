import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import login from "../pages/login/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"
import pedidoDetalhe from "../pages/Pedido/TesteIndex"
import adminDashboard from "../pages/AdminDashboard/TesteIndex"
import adminPedidos from "../pages/AdminPedidos/TesteIndex"
import editarPedido from "../pages/AdminEditarPedido/TesteIndex"
import perfil from "../pages/Perfil/TesteIndex"

import usuarios from "../fixtures/usuarios.json"
import livrosDados from "../fixtures/livros.json"
import enderecos from "../fixtures/enderecos.json"
import cartoes from "../fixtures/cartoes.json"
import cupons from "../fixtures/cupons.json"

describe('Fluxo completo de alteração de status do pedido', () => {

    beforeEach(() => {

        cy.resetarBanco()

        // =========================================
        // LOGIN ADMIN
        // =========================================

        login.visitarPagina()

        login.preencherCampo('username', usuarios.admin.email)

        login.preencherCampo('password', usuarios.admin.senha)

        login.clicarBotao('entrar')

        adminDashboard.validarAcessoPagina()

        adminDashboard.clicarBotao('pedidos')

        adminPedidos.validarAcessoPagina()
    })

    afterEach(() => {

        cy.resetarBanco()
    })

    // =========================================
    // CONFIRMADO
    // =========================================

    it('Deve refletir status CONFIRMADO para o cliente', () => {

        adminPedidos.clicarBotao('editar', 7)

        editarPedido.campo('status', 'CONFIRMADO')

        editarPedido.validarCampo('status', 'CONFIRMADO')

        editarPedido.clicarBotao('salvar')

        editarPedido.validarStatusDetalhe('CONFIRMADO')

        adminPedidos.clicarBotao('sair')

        // =========================================
        // LOGIN CLIENTE
        // =========================================

        login.visitarPagina()

        login.preencherCampo('username', usuarios.joao.email)

        login.preencherCampo('password', usuarios.joao.senha)

        login.clicarBotao('entrar')

        home.validarAcessoPagina()

        home.clicarMenu('meu_perfil')

        perfil.validarAcessoPagina()

        perfil.clicarBotao('pedidos')

        pedidos.clicarBotao('detalhesPedido')

        pedidoDetalhe.validarStatus('confirmado', true)

        pedidoDetalhe.validarStatus('separando', false)

        pedidoDetalhe.validarStatus('enviado', false)

        pedidoDetalhe.validarStatus('entregue', false)
    })

    // =========================================
    // SEPARANDO
    // =========================================

    it('Deve refletir status SEPARANDO para o cliente', () => {

        adminPedidos.clicarBotao('editar', 7)

        editarPedido.campo('status', 'SEPARANDO')

        editarPedido.validarCampo('status', 'SEPARANDO')

        editarPedido.clicarBotao('salvar')

        editarPedido.validarStatusDetalhe('SEPARANDO')

        adminPedidos.clicarBotao('sair')

        // =========================================
        // LOGIN CLIENTE
        // =========================================

        login.visitarPagina()

        login.preencherCampo('username', usuarios.joao.email)

        login.preencherCampo('password', usuarios.joao.senha)

        login.clicarBotao('entrar')

        home.clicarMenu('meu_perfil')

        perfil.clicarBotao('pedidos')

        pedidos.clicarBotao('detalhesPedido')

        pedidoDetalhe.validarStatus('confirmado', true)

        pedidoDetalhe.validarStatus('separando', true)

        pedidoDetalhe.validarStatus('enviado', false)

        pedidoDetalhe.validarStatus('entregue', false)
    })

    // =========================================
    // ENVIADO
    // =========================================

    it('Deve refletir status ENVIADO para o cliente', () => {

        adminPedidos.clicarBotao('editar', 7)

        editarPedido.campo('status', 'ENVIADO')

        editarPedido.validarCampo('status', 'ENVIADO')

        editarPedido.clicarBotao('salvar')

        editarPedido.validarStatusDetalhe('ENVIADO')

        adminPedidos.clicarBotao('sair')

        // =========================================
        // LOGIN CLIENTE
        // =========================================

        login.visitarPagina()

        login.preencherCampo('username', usuarios.joao.email)

        login.preencherCampo('password', usuarios.joao.senha)

        login.clicarBotao('entrar')

        home.clicarMenu('meu_perfil')

        perfil.clicarBotao('pedidos')

        pedidos.clicarBotao('detalhesPedido')

        pedidoDetalhe.validarStatus('confirmado', true)

        pedidoDetalhe.validarStatus('separando', true)

        pedidoDetalhe.validarStatus('enviado', true)

        pedidoDetalhe.validarStatus('entregue', false)
    })

    // =========================================
    // ENTREGUE
    // =========================================

    it('Deve refletir status ENTREGUE para o cliente', () => {

        adminPedidos.clicarBotao('editar', 7)

        editarPedido.campo('status', 'ENTREGUE')

        editarPedido.validarCampo('status', 'ENTREGUE')

        editarPedido.clicarBotao('salvar')

        editarPedido.validarStatusDetalhe('ENTREGUE')

        adminPedidos.clicarBotao('sair')

        // =========================================
        // LOGIN CLIENTE
        // =========================================

        login.visitarPagina()

        login.preencherCampo('username', usuarios.joao.email)

        login.preencherCampo('password', usuarios.joao.senha)

        login.clicarBotao('entrar')

        home.clicarMenu('meu_perfil')

        perfil.clicarBotao('pedidos')

        pedidos.clicarBotao('detalhesPedido')

        pedidoDetalhe.validarStatus('confirmado', true)

        pedidoDetalhe.validarStatus('separando', true)

        pedidoDetalhe.validarStatus('enviado', true)

        pedidoDetalhe.validarStatus('entregue', true)
    })

    // =========================================
    // CANCELADO
    // =========================================

    it('Deve refletir status CANCELADO para o cliente', () => {

        adminPedidos.clicarBotao('editar', 7)

        editarPedido.campo('status', 'CANCELADO')

        editarPedido.validarCampo('status', 'CANCELADO')

        editarPedido.clicarBotao('salvar')

        editarPedido.validarStatusDetalhe('CANCELADO')

        adminPedidos.clicarBotao('sair')

        // =========================================
        // LOGIN CLIENTE
        // =========================================

        login.visitarPagina()

        login.preencherCampo('username', usuarios.joao.email)

        login.preencherCampo('password', usuarios.joao.senha)

        login.clicarBotao('entrar')

        home.clicarMenu('meu_perfil')

        perfil.clicarBotao('pedidos')

        pedidos.clicarBotao('detalhesPedido')

        //cy.contains('CANCELADO')
        //    .should('exist')
    })
})