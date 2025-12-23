package com.example.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConexaoSQL {

    private static final String URL =
            "jdbc:sqlite:C:/Users/ritam/IdeaProjects/ESIII_HOSPEDE/hospedes.db";

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

        String sqlHospede =
                """
                CREATE TABLE IF NOT EXISTS hospede (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    cpf TEXT NOT NULL,
                    nome TEXT NOT NULL,
                    email TEXT,
                    telefone TEXT,
                    celular TEXT,
                    data_nascimento TEXT,
                    senha TEXT,
                    ativo INTEGER DEFAULT 1
                );
                """;

        String sqlEstado =
                """
                CREATE TABLE IF NOT EXISTS estado (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nome TEXT NOT NULL
                );
                """;

        String sqlCidade =
                """
                CREATE TABLE IF NOT EXISTS cidade (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    nome TEXT NOT NULL,
                    estado_id INTEGER,
                    FOREIGN KEY (estado_id) REFERENCES estado(id)
                );
                """;

        String sqlEndereco =
                """
                CREATE TABLE IF NOT EXISTS endereco (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    logradouro TEXT,
                    numero TEXT,
                    complemento TEXT,
                    bairro TEXT,
                    cidade_id INTEGER,
                    estado_id INTEGER,
                    hospede_id INTEGER,
                    FOREIGN KEY (cidade_id) REFERENCES cidade(id) ON DELETE CASCADE,
                    FOREIGN KEY (estado_id) REFERENCES estado(id) ON DELETE CASCADE,
                    FOREIGN KEY (hospede_id) REFERENCES hospede(id) ON DELETE CASCADE
                );
                """;


        try (Connection c = getInstance().getConnection();
             Statement stmt = c.createStatement()) {

            stmt.execute(sqlHospede);
            stmt.execute(sqlEstado);
            stmt.execute(sqlCidade);
            stmt.execute(sqlEndereco);

            System.out.println("Tabelas verificadas/criadas com sucesso.");

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
