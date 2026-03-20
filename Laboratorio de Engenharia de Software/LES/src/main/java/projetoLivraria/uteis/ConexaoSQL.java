package projetoLivraria.uteis;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConexaoSQL {

    private static final String URL = "jdbc:sqlite:" +
            System.getProperty("user.home") + "/livraria.db";

    private static ConexaoSQL instance;

    private ConexaoSQL() {
        try {
            Class.forName("org.sqlite.JDBC");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static ConexaoSQL getInstance() {
        if (instance == null) instance = new ConexaoSQL();
        return instance;
    }

    public Connection getConnection() throws Exception {
        return DriverManager.getConnection(URL);
    }

    public static void criarTabelasSeNaoExistirem() {

        String sqlCliente = """
                CREATE TABLE IF NOT EXISTS cliente (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nome TEXT NOT NULL,
                    genero TEXT,
                    data_nascimento DATE,
                    cpf TEXT UNIQUE NOT NULL,
                    email TEXT UNIQUE NOT NULL,
                    senha TEXT NOT NULL,
                    ranking INTEGER DEFAULT 0,
                    status TEXT NOT NULL
                );
                """;

        String sqlTelefone = """
                CREATE TABLE IF NOT EXISTS telefone (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    cliente_id INTEGER NOT NULL,
                    tipo TEXT,
                    ddd TEXT,
                    numero TEXT,
                    FOREIGN KEY(cliente_id) REFERENCES cliente(id)
                );
                """;

        String sqlPais = """
                CREATE TABLE IF NOT EXISTS pais (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nome TEXT NOT NULL
                );
                """;

        String sqlEstado = """
                CREATE TABLE IF NOT EXISTS estado (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nome TEXT NOT NULL,
                    pais_id INTEGER,
                    FOREIGN KEY(pais_id) REFERENCES pais(id)
                );
                """;

        String sqlCidade = """
                CREATE TABLE IF NOT EXISTS cidade (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nome TEXT NOT NULL,
                    estado_id INTEGER,
                    FOREIGN KEY(estado_id) REFERENCES estado(id)
                );
                """;

        String sqlEndereco = """
                CREATE TABLE IF NOT EXISTS endereco (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    cliente_id INTEGER NOT NULL,
                    tipo_residencia TEXT,
                    tipo_logradouro TEXT,
                    logradouro TEXT,
                    numero TEXT,
                    cep TEXT,
                    bairro TEXT,
                    cidade_id INTEGER,
                    observacoes TEXT,
                    tipo_endereco TEXT,
                    FOREIGN KEY(cliente_id) REFERENCES cliente(id),
                    FOREIGN KEY(cidade_id) REFERENCES cidade(id)
                );
                """;

//        String sqlBandeira =
//                """
//                CREATE TABLE IF NOT EXISTS bandeira (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    nome TEXT NOT NULL
//                );
//                """;
//
//        String sqlCartao = """
//                CREATE TABLE IF NOT EXISTS cartao (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    cliente_id INTEGER NOT NULL,
//                    numero TEXT NOT NULL,
//                    nome_impresso TEXT NOT NULL,
//                    bandeira_id INTEGER,
//                    cvv TEXT,
//                    FOREIGN KEY(cliente_id) REFERENCES cliente(id),
//                    FOREIGN KEY(bandeira_id) REFERENCES bandeira(id)
//                );
//                """;
//
//        String sqlCategoria =
//                """
//                CREATE TABLE IF NOT EXISTS categoria (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    nome TEXT NOT NULL
//                );
//                """;
//
//        String sqlGrupoPrecificacao =
//                """
//                CREATE TABLE IF NOT EXISTS grupo_precificacao (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    nome TEXT NOT NULL,
//                    margem_lucro REAL NOT NULL
//                );
//                """;
//
//        String sqlLivro =
//                """
//                CREATE TABLE IF NOT EXISTS livro (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    titulo TEXT NOT NULL,
//                    autor TEXT,
//                    editora TEXT,
//                    ano INTEGER,
//                    edicao TEXT,
//                    isbn TEXT,
//                    paginas INTEGER,
//                    sinopse TEXT,
//                    altura REAL,
//                    largura REAL,
//                    peso REAL,
//                    profundidade REAL,
//                    codigo_barras TEXT,
//                    grupo_precificacao_id INTEGER,
//                    status TEXT,
//                    FOREIGN KEY(grupo_precificacao_id) REFERENCES grupo_precificacao(id)
//                );
//                """;
//
//        String sqlLivroCategoria =
//                """
//                CREATE TABLE IF NOT EXISTS livro_categoria (
//                    livro_id INTEGER,
//                    categoria_id INTEGER,
//                    PRIMARY KEY (livro_id, categoria_id),
//                    FOREIGN KEY(livro_id) REFERENCES livro(id),
//                    FOREIGN KEY(categoria_id) REFERENCES categoria(id)
//                );
//                """;
//
//        String sqlEstoque =
//                """
//                CREATE TABLE IF NOT EXISTS estoque (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    livro_id INTEGER,
//                    quantidade INTEGER,
//                    custo REAL,
//                    FOREIGN KEY(livro_id) REFERENCES livro(id)
//                );
//                """;
//
//        String sqlPedido =
//                """
//                CREATE TABLE IF NOT EXISTS pedido (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    cliente_id INTEGER,
//                    endereco_entrega_id INTEGER,
//                    data DATETIME,
//                    valor_total REAL,
//                    status TEXT,
//                    FOREIGN KEY(cliente_id) REFERENCES cliente(id),
//                    FOREIGN KEY(endereco_entrega_id) REFERENCES endereco(id)
//                );
//                """;
//
//        String sqlitensPedido =
//                """
//                CREATE TABLE IF NOT EXISTS item_pedido (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    pedido_id INTEGER,
//                    livro_id INTEGER,
//                    quantidade INTEGER,
//                    preco REAL,
//                    FOREIGN KEY(pedido_id) REFERENCES pedido(id),
//                    FOREIGN KEY(livro_id) REFERENCES livro(id)
//                );
//                """;
//
//        String sqlCupom =
//                """
//                CREATE TABLE IF NOT EXISTS cupom (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    codigo TEXT UNIQUE,
//                    valor REAL,
//                    status TEXT,
//                    cliente_id INTEGER,
//                    FOREIGN KEY(cliente_id) REFERENCES cliente(id)
//                );
//                """;
//
//        String sqlPagamento =
//                """
//                CREATE TABLE  IF NOT EXISTS pagamento (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    pedido_id INTEGER,
//                    cartao_id INTEGER,
//                    cupom_id INTEGER,
//                    valor REAL,
//                    FOREIGN KEY(pedido_id) REFERENCES pedido(id),
//                    FOREIGN KEY(cartao_id) REFERENCES cartao(id),
//                    FOREIGN KEY(cupom_id) REFERENCES cupom(id)
//                );
//                """;
//
//        String sqlTroca =
//                """
//                CREATE TABLE IF NOT EXISTS troca (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    pedido_id INTEGER,
//                    status TEXT,
//                    data_solicitacao DATE,
//                    data_recebimento DATE,
//                    FOREIGN KEY(pedido_id) REFERENCES pedido(id)
//                );
//                """;
//
//        String sqlLog =
//                """
//                CREATE TABLE IF NOT EXISTS log (
//                    id INTEGER PRIMARY KEY AUTOINCREMENT,
//                    usuario TEXT,
//                    acao TEXT,
//                    data DATETIME
//                );
//                """;


        try (Connection c = getInstance().getConnection();
             Statement stmt = c.createStatement()) {

            stmt.execute(sqlCliente);
            stmt.execute(sqlTelefone);
            stmt.execute(sqlPais);
            stmt.execute(sqlEstado);
            stmt.execute(sqlCidade);
            stmt.execute(sqlEndereco);
//            stmt.execute(sqlBandeira);
//            stmt.execute(sqlCartao);
//            stmt.execute(sqlCategoria);
//            stmt.execute(sqlGrupoPrecificacao);
//            stmt.execute(sqlLivro);
//            stmt.execute(sqlLivroCategoria);
//            stmt.execute(sqlEstoque);
//            stmt.execute(sqlPedido);
//            stmt.execute(sqlitensPedido);
//            stmt.execute(sqlCupom);
//            stmt.execute(sqlPagamento);
//            stmt.execute(sqlTroca);
//            stmt.execute(sqlLog);

            System.out.println("Tabelas verificadas/criadas com sucesso. Banco em: " + System.getProperty("user.home") + "/livraria.db");

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}

