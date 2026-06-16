// cypress/e2e/TesteFluxoCompletoCompra.cy.js
// ==========================================
// TESTE: Cliente realizar compra
// ==========================================

import login from "../pages/login/TesteIndex"
import home from "../pages/home/TesteIndex"
import livros from "../pages/Livros/TesteIndex"
import livro from "../pages/Livro/TesteIndex"
import carrinho from "../pages/Carrinho/TesteIndex"
import checkout from "../pages/Checkout/TesteIndex"
import pedidos from "../pages/Pedidos/TesteIndex"
import perfil from "../pages/Perfil/TesteIndex"
import endereco from "../pages/Endereco/TesteIndex"
import cartoesPage from "../pages/Cartoes/TesteIndex"

import usuarios from "../fixtures/usuariosTeste.json"
import livrosDados from "../fixtures/livrosTeste.json"
import enderecos from "../fixtures/enderecosTeste.json"

import clientejson from "../fixtures/cliente.json";
import livrosjson from "../fixtures/livro.json";
import enderecojson from "../fixtures/endereco.json";
import cartaojson from "../fixtures/cartao.json";
import cupomjson from "../fixtures/cupom.json";

describe('Fluxo Completo - Cliente realizar compra', () => {

    beforeEach(() => {
        cy.resetarBanco()
    })

    afterEach(() => {
        cy.resetarBanco()
    })

    // ==========================================
    // CENÁRIO 1: Cliente logado compra com 1 cartão
    // ==========================================
    it('CT01 - Cliente logado compra 1 item com Mastercard', () => {
        // Arrange - Login
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        // Act - Adicionar produto ao carrinho
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 2)
        livro.clicarBotao('adicionarCarrinho')

        // Assert - Validar carrinho
        carrinho.validar('acessoPagina')
        carrinho.validar('quantidade', livrosjson["1984"].id, 2)

        // Act - Finalizar compra
        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id)
        checkout.preencherValorTotalNoCartao1()
        checkout.validar('cartaoBateComResumo')
        checkout.clicarBotao('finalizar')

        // Assert - Validar pedido criado
        pedidos.validar('confirmacao')
        pedidos.clicarBotao('meusPedidos')
        pedidos.validar('pedidoCadastrado')
        pedidos.clicarBotao('detalhesPedido')
        pedidos.validar('detalhePedido')
        pedidos.validar('statusConfirmado')
    })

    // ==========================================
    // CENÁRIO 2: Cliente compra com 2 cartões diferentes
    // ==========================================
    it('CT02 - Cliente compra 2 itens pagando com 2 cartões (Mastercard + ELO)', () => {
        // Arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        // Act - Adicionar 2 itens diferentes
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrosjson["Dom Casmurro"].id)
        livro.preencherCampo('quantidade', livrosjson["Dom Casmurro"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.validar('acessoPagina')
        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // Act - Pagamento com 2 cartões
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)
        checkout.preencherCampo('cartao1', cartaojson["Odete Roitman Mastercard"].id) // Mastercard
        checkout.preencherCartoes('37.90', '20.00') // Valores divididos
        checkout.preencherCampo('selectCartao2', cartaojson["Odete Roitman Visa"].id) // ELO
        checkout.clicarBotao('finalizar')

        // Assert
        pedidos.validar('confirmacao')
    })

    // ==========================================
    // CENÁRIO 3: Cliente compra usando cupom de desconto
    // ==========================================
    it('CT03 - Cliente compra aplicando cupom de desconto promocional', () => {
        // Arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        // Act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)

        // Aplicar cupom
        checkout.selecionarCupom(cupomjson["SUPER_DESCONTO"].id)

        checkout.validar('cupomAplicado')
        checkout.validar('resumo')
        checkout.preencherValorTotalNoCartao1()
        checkout.clicarBotao('finalizar')

        // Assert
        pedidos.validar('confirmacao')
    })

    // ==========================================
    // CENÁRIO 4: Cliente compra com cupom de troca
    // ==========================================
    it('CT04 - Cliente compra aplicando cupom de troca gerado anteriormente', () => {
        // Arrange
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        // Act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)

        // Aplicar cupom de troca
        checkout.selecionarCupom(cupomjson["TROCA-7AEFEAB2"].id) // Cupom de troca
        checkout.validar('cupomAplicado')
        checkout.preencherValorTotalNoCartao1()
        checkout.clicarBotao('finalizar')

        pedidos.validar('confirmacao')
    })

    // ==========================================
    // CENÁRIO 5: Cliente compra com múltiplos cupons (promocional + troca)
    // ==========================================
    it('CT05 - Cliente compra com cupom promocional + cupom de troca simultaneamente', () => {
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 2)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)

        // Selecionar múltiplos cupons
        checkout.selecionarCupom(cupomjson["SUPER_DESCONTO"].id) //Promocional R$20
        checkout.selecionarCupom(cupomjson["TROCA-7AEFEAB2"].id) // Troca

        checkout.validar('resumo')
        checkout.preencherValorTotalNoCartao1()
        checkout.clicarBotao('finalizar')

        pedidos.validar('confirmacao')
    })

    // ==========================================
    // CENÁRIO 6: Cliente compra com múltiplos cupons (promocional + 2 troca maior que pedido)
    // ==========================================
    it('CT06 - Cliente compra com cupom promocional + 2 cupom de troca simultaneamente', () => {
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 2)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)

        // Selecionar múltiplos cupons
        checkout.selecionarCupom(cupomjson["SUPER_DESCONTO"].id) //Promocional R$20
        checkout.selecionarCupom(cupomjson["TROCA-7AEFEAB2"].id) // Troca
        checkout.selecionarCupom(cupomjson["TROCA-EDD7417F"].id) // Troca

        checkout.validar('resumo')
        checkout.preencherValorTotalNoCartao1()
    })

    // ==========================================
    // CENÁRIO 7: Cliente compra com múltiplos cupons (promocional + 2 troca)
    // ==========================================
    it('CT05 - Cliente compra com cupom promocional + cupom de troca simultaneamente', () => {
        login.visitarPagina()
        login.preencherCampo('username', clientejson["Odete Roitman"].email)
        login.preencherCampo('password', clientejson["Odete Roitman"].senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosjson["1984"].id)
        livro.preencherCampo('quantidade', livrosjson["1984"].id, 5)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecojson["dos Bobos"].id)

        // Selecionar múltiplos cupons
        checkout.selecionarCupom(cupomjson["SUPER_DESCONTO"].id) //Promocional R$20
        checkout.selecionarCupom(cupomjson["TROCA-7AEFEAB2"].id) // Troca
        checkout.selecionarCupom(cupomjson["TROCA-EDD7417F"].id) // Troca

        checkout.validar('resumo')
        checkout.preencherValorTotalNoCartao1()
        checkout.clicarBotao('finalizar')
        pedidos.validar('confirmacao')
    })

})