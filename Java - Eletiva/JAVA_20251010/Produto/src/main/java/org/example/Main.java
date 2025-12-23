package org.example;

import java.sql.Connection;
import java.sql.Statement;
import java.util.List;

/*
1. Conexão e Teste: Crie uma classe principal que apenas abra e feche uma conexão com o banco de dados.
Imprima no console "Conexão estabelecida com sucesso!" ou a mensagem de erro.
Use o try-catch-finally tradicional para garantir o fechamento.
*/

public class Main {
    public static void main(String[] args) {

        String sql = "CREATE TABLE IF NOT EXISTS PRODUTO ( " +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "nome VARCHAR(100) NOT NULL, " +
                "preco DECIMAL(10,2) NOT NULL, " +
                "estoque INT " +
                "); ";

        Connection c = null;
        Statement s = null;

        try {
            c = ConexaoSQL.conectar();
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

        System.out.println("Banco de produtos");
        ProdutoDAOImpl dao = new ProdutoDAOImpl();

        System.out.println("\nInserindo produtos");
        dao.salvar(new Produto(0, "Mouse", 120.0, 10));
        dao.salvar(new Produto(0, "Teclado Mecânico", 250.0, 5));
        dao.salvar(new Produto(0, "Monitor", 900.0, 3));

        System.out.println("\nListando");
        List<Produto> produtos = dao.buscarTodos();
        for (Produto p : produtos) {
            System.out.printf("ID: %d | Nome: %s | Preço: %.2f | Estoque: %d%n",
                    p.getId(), p.getNome(), p.getPreco(), p.getEstoque());
        }
        System.out.println("\nConsultando por id (id = 1)");
        ConsultaProduto.consulta(1);

        System.out.println("\nTransferindo o estoque (id 1 -> id 2, qtd = 2)");
        dao.transferirEstoque(1, 2, 2);

        System.out.println("\nListando");
        List<Produto> atualizados = dao.buscarTodos();
        for (Produto p : atualizados) {
            System.out.printf("ID: %d | Nome: %s | Preço: %.2f | Estoque: %d%n",
                    p.getId(), p.getNome(), p.getPreco(), p.getEstoque());
        }
    }
}