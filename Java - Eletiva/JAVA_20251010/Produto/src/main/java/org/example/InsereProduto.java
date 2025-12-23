package org.example;

import java.sql.Connection;
import java.sql.PreparedStatement;

/*
3. Inserção Segura: Usando a interface PreparedStatement, crie um método para inserir um novo produto na tabela.
Receba o nome, preco e estoque como parâmetros.
Garanta o uso do método executeUpdate().
 */

public class InsereProduto {
    public static void inserir(String produto, double preco, int estoque) {
        String sql = "INSERT INTO PRODUTO (produto, preco, estoque) VALUES (?, ?, ?)";

        try (Connection c = ConexaoSQL.conectar(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, produto);
            p.setDouble(2, preco);
            p.setInt(3, estoque);
            p.executeUpdate();
            System.out.println("\nProduto Inserido");
        } catch (Exception e) {
            System.out.println("\nErro ao inserir: " + e.getMessage());
        }
    }
}