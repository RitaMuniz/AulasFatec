package org.example;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/*
6. Implementação do Método salvar: Crie a classe ProdutoDAOImpl que implementa a interface ProdutoDAO.
Refatore o código do exercício 3 para o método salvar(Produto produto), usando PreparedStatement e o objeto Produto para obter os dados.

7. Implementação do Método buscarTodos: Implemente o método buscarTodos() na classe ProdutoDAOImpl.
Refatore o código do exercício 2, mas desta vez popule uma lista de objetos Produto a partir do ResultSet e retorne essa lista.

8. Atualização Transacional: Crie um método chamado transferirEstoque(int idOrigem, int idDestino, int quantidade) na ProdutoDAOImpl.
Este método deve:
o Diminuir o estoque do produto de idOrigem.
o Aumentar o estoque do produto de idDestino.
o Envolva ambas as operações em uma transação (setAutoCommit(false)), aplicando commit() se ambas as operações forem bem-sucedidas ou rollback() se houver alguma exceção.
o Desafio extra: Garanta que todo o código JDBC na ProdutoDAOImpl utilize o bloco try-with-resources.
*/

public class ProdutoDAOImpl implements ProdutoDAO {

    @Override
    public void salvar(Produto produto) {
        String sql = "INSERT INTO PRODUTO (nome, preco, estoque) VALUES (?, ?, ?)";

        try (Connection c = ConexaoSQL.conectar(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, produto.getNome());
            p.setDouble(2, produto.getPreco());
            p.setInt(3, produto.getEstoque());
            p.executeUpdate();
            System.out.println("\nProduto Inserido");
        } catch (Exception e) {
            System.out.println("\nErro ao inserir: " + e.getMessage());
        }
    }

    public List<Produto> buscarTodos() {
        String sql = "SELECT * FROM PRODUTO";
        List<Produto> produtos = new ArrayList<>();

        try (Connection c = ConexaoSQL.conectar();
             Statement s = c.createStatement();
             ResultSet r = s.executeQuery(sql)) {

            while (r.next()) {
                Produto p = new Produto(
                        r.getInt("id"),
                        r.getString("nome"),
                        r.getDouble("preco"),
                        r.getInt("estoque")
                );
                produtos.add(p);
            }
        } catch (Exception e) {
            System.out.println("\nErro ao listar: " + e.getMessage());
        }
        return produtos;
    }

    public void transferirEstoque(int idOrigem, int idDestino, int quantidade) {
        String sqlSubtrair = "UPDATE PRODUTO SET estoque = estoque - ? WHERE id = ?";
        String sqlAdicionar = "UPDATE PRODUTO SET estoque = estoque + ? WHERE id = ?";

        try (Connection c = ConexaoSQL.conectar()) {
            c.setAutoCommit(false);

            try (PreparedStatement p1 = c.prepareStatement(sqlSubtrair);
                 PreparedStatement p2 = c.prepareStatement(sqlAdicionar)) {

                p1.setInt(1, quantidade);
                p1.setInt(2, idOrigem);
                p1.executeUpdate();

                p2.setInt(1, quantidade);
                p2.setInt(2, idDestino);
                p2.executeUpdate();

                c.commit();
                System.out.println("Transferência realizada com sucesso!");
            } catch (Exception e) {
                c.rollback();
                System.out.println("Erro na transferência: " + e.getMessage());
            } finally {
                c.setAutoCommit(true);
            }
        } catch (Exception e) {
            System.out.println("Erro: " + e.getMessage());
        }
    }
}
