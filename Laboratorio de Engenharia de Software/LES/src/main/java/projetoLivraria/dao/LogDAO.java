package projetoLivraria.dao;

import projetoLivraria.uteis.ConexaoSQL;

import java.net.URISyntaxException;
import java.sql.*;

public class LogDAO {

    public void registrar(String usuario, String acao, String tabela,
                          String dadosAnteriores, String dadosNovos) {
        String sql = """
            INSERT INTO log (usuario, acao, data, tabela, dados_anteriores, dados_novos)
            VALUES (?, ?, datetime('now','localtime'), ?, ?, ?)
        """;

        try (Connection conn = ConexaoSQL.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, usuario != null ? usuario : "sistema");
            stmt.setString(2, acao);
            stmt.setString(3, tabela);
            stmt.setString(4, dadosAnteriores);
            stmt.setString(5, dadosNovos);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("[LogDAO] Erro ao registrar log: " + e.getMessage());
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}