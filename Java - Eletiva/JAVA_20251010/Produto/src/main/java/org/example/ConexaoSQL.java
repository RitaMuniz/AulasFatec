package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
1. Conexão e Teste: Crie uma classe principal que apenas abra e feche uma conexão com o banco de dados.
Imprima no console "Conexão estabelecida com sucesso!" ou a mensagem de erro.
Use o try-catch-finally tradicional para garantir o fechamento.
*/

public class ConexaoSQL {

    private static final String URL = "jdbc:sqlite:Produto.db";

    public static Connection conectar() {
        try {
            return DriverManager.getConnection(URL);
        } catch (SQLException e) {
            System.out.println("\nErro de conexão: " + e.getMessage());
            return null;
        }
    }

}
