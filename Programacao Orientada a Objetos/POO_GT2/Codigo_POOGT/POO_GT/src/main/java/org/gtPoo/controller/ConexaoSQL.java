package org.gtPoo.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConexaoSQL {
    private static final String URL = "jdbc:sqlite:POOGT.db";

    public static void conexao() {
        String sql1 =
                "CREATE TABLE IF NOT EXISTS usuario (" +
                "  id INTEGER PRIMARY KEY AUTOINCREMENT,\n" +
                "  nome TEXT NOT NULL,\n" +
                "  email TEXT,\n" +
                "  telefone TEXT,\n" +
                "  numero_registro TEXT,\n" +
                "  tipo TEXT\n" +
                ");\n" +
                "\n";
        String sql2 =
                "CREATE TABLE IF NOT EXISTS livro (\n" +
                "  id INTEGER PRIMARY KEY AUTOINCREMENT,\n" +
                "  titulo TEXT NOT NULL,\n" +
                "  isbn TEXT,\n" +
                "  autor TEXT,\n" +
                "  tipo TEXT NOT NULL\n" +
                ");\n";
        String sql3 =
                "CREATE TABLE IF NOT EXISTS emprestimo (\n" +
                "  id INTEGER PRIMARY KEY AUTOINCREMENT,\n" +
                "  usuario_id INTEGER NOT NULL,\n" +
                "  livro_id INTEGER NOT NULL,\n" +
                "  data_retirada TEXT,\n" +
                "  data_devolucao TEXT,\n" +
                "  FOREIGN KEY(usuario_id) REFERENCES usuario(id),\n" +
                "  FOREIGN KEY(livro_id) REFERENCES livro(id)\n" +
                ");\n";

        Connection c = null;
        Statement s = null;

        try {
            c = conectar();
            s = c.createStatement();
            s.execute(sql1);
            s.execute(sql2);
            s.execute(sql3);
            System.out.println("Conexão estabelecida com sucesso!");
        } catch (Exception e) {
            System.out.println("Erro: " + e.getMessage());
        } finally {
            try {
                if (s != null) s.close();
                if (c != null) c.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static Connection conectar() {
        try {
            return DriverManager.getConnection(URL);
        } catch (SQLException e) {
            System.out.println("\nErro de conexão: " + e.getMessage());
            return null;
        }
    }
}
