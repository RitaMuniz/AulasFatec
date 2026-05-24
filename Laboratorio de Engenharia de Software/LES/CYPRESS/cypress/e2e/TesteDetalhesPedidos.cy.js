import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import login from "../pages/login/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"

import usuarios from "../fixtures/usuarios.json"
import livrosDados from "../fixtures/livros.json"
import enderecos from "../fixtures/enderecos.json"
import cartoes from "../fixtures/cartoes.json"
import cupons from "../fixtures/cupons.json"

describe('Fluxo completo de pedido', () => {

    beforeEach(() => {
        // arrange
        cy.resetarBanco()
        login.visitarPagina()
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')
    })

    afterEach(() => {
        // cleanup
        cy.resetarBanco()
    })


    it('Acessar a pagina', () => {

        // arrange


        home.validarAcessoPagina()

        home.clicarMenu('meu_perfil')
    })
})