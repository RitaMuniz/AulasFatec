package org.gtJava.controller.dao;

import javafx.scene.control.Alert;
import org.gtJava.controller.conexao.ConexaoSQL;
import org.gtJava.model.Reflorestamento;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TabelaReflorestamentoDAO {


    public void salvar(Reflorestamento reflorestamento) {
        if (existeAno(reflorestamento.getAno())) {
            mostrarErro("Erro: já há registro nesse ano ");
            return;
        }

        String sql = "INSERT INTO TabelaReflorestamento (ano, valorRecente) VALUES (?, ?)";
        try (Connection c = ConexaoSQL.conectar();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, reflorestamento.getAno());
            ps.setDouble(2, reflorestamento.getValorRecente());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Reflorestamento> lista() {
        List<Reflorestamento> lista = new ArrayList<>();
        String sql = "SELECT * FROM TabelaReflorestamento";
        try (Connection c = ConexaoSQL.conectar();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery(sql)) {
            while (rs.next()) {
                Reflorestamento r = new Reflorestamento();
                r.setId(rs.getInt("id"));
                r.setAno(rs.getInt("ano"));
                r.setValorRecente(rs.getDouble("valorRecente"));
                lista.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public void excluir(int id) {
        String sql = "DELETE FROM TabelaReflorestamento WHERE id = ?";
        try (Connection c = ConexaoSQL.conectar();
             PreparedStatement p = c.prepareStatement(sql)) {
            p.setInt(1, id);
            p.executeUpdate();
            System.out.println("Excluido!");
        } catch (Exception e) {
            System.out.println("\nErro ao excluir: " + e.getMessage());
        }

    }

    public void editar(Reflorestamento reflorestamento) {
        String sql = "UPDATE TabelaReflorestamento SET ano = ?, valorRecente = ? WHERE id = ?";

        try (Connection c = ConexaoSQL.conectar()) {
            c.setAutoCommit(false);

            try (PreparedStatement p = c.prepareStatement(sql)) {

                p.setInt(1, reflorestamento.getAno());
                p.setDouble(2, reflorestamento.getValorRecente());
                p.setInt(3, reflorestamento.getId());
                p.executeUpdate();

                c.commit();
                System.out.println("Editado!");
            } catch (Exception e) {
                c.rollback();
                System.out.println("Erro: " + e.getMessage());
            } finally {
                c.setAutoCommit(true);
            }
        } catch (Exception e) {
            System.out.println("Erro: " + e.getMessage());
        }
    }

    public boolean existeAno(int ano) {
        String sql = "SELECT COUNT(*) FROM TabelaReflorestamento WHERE ano = ?";
        try (Connection c = ConexaoSQL.conectar();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setInt(1, ano);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private void mostrarErro(String mensagem) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Erro");
        alert.setHeaderText(null);
        alert.setContentText(mensagem);
        alert.showAndWait();
    }

}
