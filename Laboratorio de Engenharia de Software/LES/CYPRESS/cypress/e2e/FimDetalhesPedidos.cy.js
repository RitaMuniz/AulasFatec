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

describe('Fluxo completo de pedido', () => {

    beforeEach(() => {
        // arrange
        cy.resetarBanco()
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
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