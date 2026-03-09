package projetoLivraria.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConexaoSQL {

    private static final String URL =
            "jdbc:sqlite:/LES/livraria.db";

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

        String sqlCliente =
                """
                CREATE TABLE IF NOT EXISTS CLIENTES (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    genero TEXT NOT NULL,
                    cpf TEXT NOT NULL,
                    nome TEXT NOT NULL,
                    email TEXT NOT NULL,
                    telefone TEXT NOT NULL,
                    celular TEXT NOT NULL,
                    dataNascimento TEXT NOT NULL,
                    senha TEXT NOT NULL,
                );
                """;

        String sqlPais =
                """
                CREATE TABLE IF NOT EXISTS PAISES (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nome TEXT NOT NULL,
                    sigla TEXT NOT NULL,
                );
                """;
        String sqlEstado =
                """
                CREATE TABLE IF NOT EXISTS ESTADOS (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nome TEXT NOT NULL,
                    uf TEXT NOT NULL,
                    paises_id INTEGER,
                    FOREIGN KEY (paises_id) REFERENCES PAISES(id)
                );
                """;

        String sqlCidade =
                """
                CREATE TABLE IF NOT EXISTS CIDADES (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nome TEXT NOT NULL,
                    estado_id INTEGER,
                    FOREIGN KEY (estados_id) REFERENCES ESTADOS(id)
                );
                """;

        String sqlEndereco =
                """
                CREATE TABLE IF NOT EXISTS ENDERECOS (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    tipoLogradouro TEXT NOT NULL,
                    tipoResidencia TEXT NOT NULL,
                    logradouro TEXT NOT NULL,
                    numero TEXT NOT NULL,
                    complemento TEXT NOT NULL,
                    cep TEXT NOT NULL,
                    bairro TEXT NOT NULL,
                    observacao TEXT,
                    cidade_id INTEGER,
                    estado_id INTEGER,
                    pais_id INTEGER,
                    cliente_id INTEGER,
                    FOREIGN KEY (cidade_id) REFERENCES CIDADES(id) ON DELETE CASCADE,
                    FOREIGN KEY (estado_id) REFERENCES ESTADOS(id) ON DELETE CASCADE,
                    FOREIGN KEY (pais_id) REFERENCES PAISES(id) ON DELETE CASCADE,
                    FOREIGN KEY (cliente_id) REFERENCES CLIENTES(id) ON DELETE CASCADE
                );
                """;

        String sqlCartao =
                """
                CREATE TABLE IF NOT EXISTS CARTOES (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nomeCompleto TEXT NOT NULL,
                    nomeCartao TEXT NOT NULL,
                    bandeira TEXT NOT NULL,
                    ncartao TEXT NOT NULL,
                    cvv TEXT NOT NULL,
                );
                """;


        try (Connection c = getInstance().getConnection();
             Statement stmt = c.createStatement()) {

            stmt.execute(sqlCliente);
            stmt.execute(sqlPais);
            stmt.execute(sqlEstado);
            stmt.execute(sqlCidade);
            stmt.execute(sqlEndereco);
            stmt.execute(sqlCartao);

            System.out.println("Tabelas verificadas/criadas com sucesso.");

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}

