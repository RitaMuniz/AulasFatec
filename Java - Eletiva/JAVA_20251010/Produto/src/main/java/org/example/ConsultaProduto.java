package org.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/*
2. Consulta Simples: Usando a interface Statement, execute um SELECT * FROM PRODUTO.
Itere sobre o ResultSet e imprima no console o nome e o preco de cada produto.

4. Busca Parametrizada: Usando PreparedStatement, crie um método que receba um id como parâmetro e busque o produto correspondente (SELECT ... WHERE id = ?).
Imprima os detalhes do produto encontrado.
Se não encontrar, imprima uma mensagem de aviso.
*/

public class ConsultaProduto {

    public static void consultaSimples() {
        String sql = "SELECT * FROM PRODUTO";

        try (Connection c = ConexaoSQL.conectar();
             Statement s = c.createStatement();
             ResultSet r = s.executeQuery(sql)) {

            System.out.println("\nItens da tabela:");
            while (r.next()) {
                System.out.println(
                        r.getInt("id") + " | " +
                                r.getString("nome") + " | " +
                                r.getDouble("preco")
                );
            }

        } catch (Exception e) {
            System.out.println("\nErro ao listar: " + e.getMessage());
        }
    }

    public static void consulta(int id) {
        String sql = "SELECT * FROM PRODUTO WHERE id = ?";

        try (Connection c  = ConexaoSQL.conectar();
             PreparedStatement p = c.prepareStatement(sql)) {

            p.setInt(1, id);

            System.out.println("\nResultado da busca: ");
            try (ResultSet r = p.executeQuery()) {
                if (r.next()) {
                    System.out.println(
                            r.getInt("id") + " | " +
                                    r.getString("nome") + " | " +
                                    r.getDouble("preco") + " | " +
                                    r.getInt("estoque")
                    );
                } else {
                    System.out.println("\nNenhum produto encontrado para o id: " + id);
                }
            }
        } catch (Exception e) {
            System.out.println("\nErro ao consultar: " + e.getMessage());
        }
    }
}