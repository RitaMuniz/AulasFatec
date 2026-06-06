# 📚 Livraria Online

Sistema web de e-commerce para venda de livros desenvolvido em Java utilizando Servlets, JSP e SQLite, seguindo a arquitetura MVC (Model-View-Controller).

O sistema permite que clientes realizem compras de livros, gerenciem seus dados pessoais, acompanhem pedidos e solicitem trocas. Além disso, conta com uma área administrativa para gerenciamento de pedidos, trocas e relatórios de vendas.

---

## 🚀 Funcionalidades

### Cliente

* Cadastro de clientes
* Login e logout
* Gerenciamento de perfil
* Gerenciamento de endereços
* Gerenciamento de cartões de crédito
* Consulta ao catálogo de livros
* Visualização de detalhes dos livros
* Carrinho de compras
* Checkout com múltiplas formas de pagamento
* Aplicação de cupons de desconto
* Histórico de pedidos
* Acompanhamento de status dos pedidos
* Solicitação de troca de produtos

### Administrador

* Dashboard administrativo
* Consulta e gerenciamento de pedidos
* Atualização de status dos pedidos
* Gestão de trocas e devoluções
* Relatórios de vendas
* Gerenciamento de clientes

### Recursos Adicionais

* Sistema de cupons
* Registro de logs
* Chatbot integrado
* Testes automatizados End-to-End

---

## 🏗️ Arquitetura

O projeto foi desenvolvido utilizando o padrão MVC (Model-View-Controller).

### Controller

Responsável pelo recebimento das requisições e controle do fluxo da aplicação.

Exemplos:

* ClienteController
* LoginController
* LivroController
* CarrinhoController
* PedidoController
* TrocaController
* RelatorioVendasController

### Model

Representa as entidades de negócio.

Exemplos:

* Cliente
* Livro
* Pedido
* Carrinho
* Cupom
* Cartão
* Troca

### DAO

Responsável pela persistência e acesso aos dados.

Exemplos:

* ClienteDAO
* LivroDAO
* PedidoDAO
* CarrinhoDAO
* TrocaDAO

### Service

Contém as regras de negócio e validações.

Exemplos:

* ClienteService
* PedidoService
* LogService

---

## 🛠️ Tecnologias Utilizadas

### Backend

* Java 17
* Jakarta Servlet API
* JSP (Java Server Pages)
* Maven

### Banco de Dados

* SQLite 3.40.1

### Frontend

* HTML5
* CSS3
* JSP

### Testes

* Cypress

### Integração Contínua

* GitHub Actions

### Servidor de Aplicação

* Apache Tomcat 10.1.52
* Smart Tomcat (plugin para execução local)

---

## 📂 Estrutura do Projeto

```text
src/main/java/projetoLivraria
├── controller
├── dao
├── model
├── service
└── uteis

src/main/webapp/view
├── páginas JSP
├── CSS
└── telas administrativas

CYPRESS
├── e2e
├── fixtures
├── pages
└── support
```

---

## ⚙️ Pré-requisitos

Antes de executar o projeto, instale:

* OpenJDK 17

```bash
java -version
```

Saída esperada:

```text
openjdk version "17.0.17"
```

* Apache Tomcat 10.1.52
* SQLite 3.40.1
* Maven 3.9+

---

## ▶️ Executando o Projeto

### 1. Clonar o repositório

```bash
git clone <URL_DO_REPOSITORIO>
cd livraria-online
```

### 2. Compilar o projeto

```bash
mvn clean package
```

### 3. Configurar o banco de dados

O projeto utiliza SQLite.

Certifique-se de que o arquivo do banco esteja configurado corretamente na classe responsável pela conexão:

```java
ConexaoSQL.java
```

### 4. Executar no Tomcat

Realize o deploy da aplicação utilizando o Tomcat ou o plugin Smart Tomcat da IDE.

Após a inicialização, acesse:

```text
http://localhost:8080/LES
```

---

## 🧪 Testes Automatizados

O projeto possui testes End-to-End desenvolvidos com Cypress.

### Instalação das dependências

```bash
npm install
```

### Executar testes em modo gráfico

```bash
npx cypress open
```

### Executar testes em linha de comando

```bash
npx cypress run
```

---

## 🔄 Integração Contínua

O projeto possui pipeline automatizada utilizando GitHub Actions.

Arquivo de configuração:

```text
.github/workflows/ci.yml
```

As validações podem incluir:

* Build da aplicação
* Execução dos testes
* Verificação de integridade do código

---

## 📊 Principais Módulos

| Módulo        | Descrição                             |
| ------------- | ------------------------------------- |
| Clientes      | Cadastro e manutenção de clientes     |
| Livros        | Catálogo e consulta de livros         |
| Carrinho      | Gerenciamento dos itens da compra     |
| Pedidos       | Controle de compras realizadas        |
| Pagamentos    | Processamento dos pagamentos          |
| Trocas        | Solicitação e gerenciamento de trocas |
| Cupons        | Aplicação e geração de descontos      |
| Relatórios    | Indicadores e vendas                  |
| Administração | Gestão operacional da plataforma      |

---

## 🎓 Contexto Acadêmico

Projeto desenvolvido para a disciplina de Laboratório de Engenharia de Software (LES), aplicando conceitos de:

* Arquitetura MVC
* Persistência de dados
* Engenharia de Software
* Testes automatizados
* Integração contínua
* Desenvolvimento Web Java

---

## 👥 Equipe

Rita Muniz e Caíque Antunes

---

## 📄 Licença

Este projeto foi desenvolvido para fins acadêmicos e educacionais.


