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

import usuarios from "../fixtures/usuarios.json"
import livrosDados from "../fixtures/livros.json"
import enderecos from "../fixtures/enderecos.json"

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
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        // Act - Adicionar produto ao carrinho
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 2)
        livro.clicarBotao('adicionarCarrinho')

        // Assert - Validar carrinho
        carrinho.validar('acessoPagina')
        carrinho.validar('quantidade', livrosDados.livro1.id, 2)

        // Act - Finalizar compra
        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        checkout.preencherCampo('endereco', enderecos.maria.entrega)
        checkout.preencherCampo('cartao1', '10') // Mastercard ID
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
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        // Act - Adicionar 2 itens diferentes
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('continuarComprando')
        livros.clicarBotao('detalhesLivro', livrosDados.livro2.id)
        livro.preencherCampo('quantidade', livrosDados.livro2.id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.validar('acessoPagina')
        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')

        // Act - Pagamento com 2 cartões
        checkout.preencherCampo('endereco', enderecos.maria.entrega)
        checkout.preencherCampo('cartao1', '10') // Mastercard
        checkout.preencherCartoes('37.13', '20.00') // Valores divididos
        cy.get('[data-test="checkbox-cartao-2"]').check()
        checkout.preencherCampo('selectCartao2', '8') // ELO
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
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        // Act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecos.maria.entrega)

        // Aplicar cupom
        checkout.selecionarCupom(6) // Cupom de R$ 20,00

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
        login.preencherCampo('username', usuarios.rita.email) // Rita possui cupom de troca
        login.preencherCampo('password', usuarios.rita.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        // Act
        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 1)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecos.rita.principal)

        // Aplicar cupom de troca
        checkout.selecionarCupom(7) // Cupom de troca
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
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 2)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecos.maria.entrega)

        // Selecionar múltiplos cupons
        checkout.selecionarCupom(6) // Promocional R$20
        checkout.selecionarCupom(8) // Troca

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
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 2)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecos.maria.entrega)

        // Selecionar múltiplos cupons
        checkout.selecionarCupom(6) // Promocional R$20
        checkout.selecionarCupom(8) // Troca
        checkout.selecionarCupom(9) // Troca

        checkout.validar('resumo')
        checkout.preencherValorTotalNoCartao1()
    })

    // ==========================================
    // CENÁRIO 7: Cliente compra com múltiplos cupons (promocional + 2 troca)
    // ==========================================
    it('CT05 - Cliente compra com cupom promocional + cupom de troca simultaneamente', () => {
        login.visitarPagina()
        login.preencherCampo('username', usuarios.maria.email)
        login.preencherCampo('password', usuarios.maria.senha)
        login.clicarBotao('entrar')
        home.validarAcessoPagina()

        home.clicarMenu('livros')
        livros.clicarBotao('detalhesLivro', livrosDados.livro1.id)
        livro.preencherCampo('quantidade', livrosDados.livro1.id, 5)
        livro.clicarBotao('adicionarCarrinho')

        carrinho.clicarBotao('finalizar')
        checkout.validar('estrutura')
        checkout.preencherCampo('endereco', enderecos.maria.entrega)

        // Selecionar múltiplos cupons
        checkout.selecionarCupom(6) // Promocional R$20
        checkout.selecionarCupom(8) // Troca
        checkout.selecionarCupom(9) // Troca

        checkout.validar('resumo')
        checkout.preencherValorTotalNoCartao1()
        checkout.clicarBotao('finalizar')
        pedidos.validar('confirmacao')
    })

})