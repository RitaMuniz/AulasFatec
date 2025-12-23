package org.example;

import java.sql.*;

public class Main {
    public static void main(String[] args) {

        String sql = "CREATE TABLE IF NOT EXISTS veiculos ( " +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "marca TEXT[30] NOT NULL, " +
                "modelo TEXT[30] NOT NULL, " +
                "placa TEXT[7] NOT NULL, " +
                "ano TEXT[4] NOT NULL " +
                "); ";

        try (Connection c = ConexaoSQLite.conectar(); Statement s = c.createStatement()) {
            s.execute(sql);
            System.out.println("Tabela criada.");
        } catch (Exception e) {
            System.out.println("Erro: " + e.getMessage());
        }

        InsereVeiculo.inserir("Fiat", "Uno", "AAA1111", "1970");
        InsereVeiculo.inserir("BYD", "Dolphin", "ZZZ1234", "2025");
        InsereVeiculo.inserir("WolksWagen", "Voyage", "ABC1234", "2011");
        InsereVeiculo.inserir("Renault", "KWID", "DEF5678", "2018");
        InsereVeiculo.inserir("Peaugeot", "208", "GHI9012", "2015");

        ListaVeiculo.listar();

        ConsultaPlaca.consulta("ABC1234");

        ExcluirVeiculo.deletar(15);

        ListaVeiculo.listar();

    }
}

class ConexaoSQLite {
    private static final String URL = "jdbc:sqlite:veiculo.db";

    public static Connection conectar() {
        try {
            return DriverManager.getConnection(URL);
        } catch (SQLException e) {
            System.out.println("\nErro de conexão: " + e.getMessage());
            return null;
        }
    }
}

class InsereVeiculo {
    public static void inserir(String marca, String modelo, String placa, String ano) {
        String sql = "INSERT INTO veiculos (marca, modelo, placa, ano) VALUES (?, ?, ?, ?)";

        try (Connection c = ConexaoSQLite.conectar(); PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1, marca);
            p.setString(2, modelo);
            p.setString(3, placa);
            p.setString(4, ano);
            p.executeUpdate();
            System.out.println("\nVeiculo Inserido");
        } catch (Exception e) {
            System.out.println("\nErro ao inserir: " + e.getMessage());
        }
    }
}

class ListaVeiculo {
    public static void listar() {
        String sql = "SELECT * FROM veiculos";

        try (Connection c = ConexaoSQLite.conectar();
             Statement s = c.createStatement();
             ResultSet r = s.executeQuery(sql)) {

            System.out.println("\nItens da tabela:");
            while (r.next()) {
                System.out.println(
                        r.getInt("id") + " | " +
                                r.getString("marca") + " | " +
                                r.getString("modelo") + " | " +
                                r.getString("placa") + " | " +
                                r.getString("ano")
                );
            }

        } catch (Exception e) {
            System.out.println("\nErro ao listar: " + e.getMessage());
        }
    }
}

class ConsultaPlaca {
    public static void consulta(String placa) {
        String sql = "SELECT * FROM veiculos WHERE placa = ?";

        try (Connection c  = ConexaoSQLite.conectar();
             PreparedStatement p = c.prepareStatement(sql)) {

            p.setString(1, placa);

            System.out.println("\nResultado da busca: ");
            try (ResultSet r = p.executeQuery()) {
                if (r.next()) {
                    System.out.println(
                                    r.getInt("id") + " | " +
                                    r.getString("marca") + " | " +
                                    r.getString("modelo") + " | " +
                                    r.getString("placa") + " | " +
                                    r.getString("ano")
                    );
                } else {
                    System.out.println("\nNenhum veículo encontrado para a placa: " + placa);
                }
            }


        } catch (Exception e) {
            System.out.println("\nErro ao cunsultar: " + e.getMessage());
        }
    }
}

class ExcluirVeiculo {
    public static void deletar(int id) {
        String sql = "DELETE FROM veiculos WHERE id = ?";
        try (Connection c = ConexaoSQLite.conectar();
             PreparedStatement p = c.prepareStatement(sql)) {
            p.setInt(1, id);
            p.executeUpdate();
            System.out.println("\nVeiculo" + id + " excluido!");
        } catch (Exception e) {
            System.out.println("\nErro ao excluir: " + e.getMessage());
        }
    }
}