package org.gtJava.controller.conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConexaoSQL {

    private static final String URL = "jdbc:sqlite:JAVAGT.db";

    public static void conexao() {
        String sql = "CREATE TABLE IF NOT EXISTS TabelaReflorestamento ( " +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "ano INTEGER NOT NULL, " +
                "valorRecente DECIMAL(10,2) NOT NULL " +
                "); ";

        Connection c = null;
        Statement s = null;

        try {
            c = conectar();
            s = c.createStatement();
            s.execute(sql);
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