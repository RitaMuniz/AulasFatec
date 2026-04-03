package projetoLivraria.dao;

import projetoLivraria.uteis.ConexaoSQL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class CidadeDAO {

    public int buscarOuCriar(String nome, int estadoId) {
        try (Connection conn = ConexaoSQL.getInstance().getConnection()) {

            // 1. BUSCAR
            String select = "SELECT id FROM cidade WHERE nome = ? AND estado_id = ?";
            PreparedStatement ps = conn.prepareStatement(select);
            ps.setString(1, nome);
            ps.setInt(2, estadoId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("id");
            }

            // 2. INSERIR
            String insert = "INSERT INTO cidade (nome, estado_id) VALUES (?, ?)";
            PreparedStatement psInsert = conn.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
            psInsert.setString(1, nome);
            psInsert.setInt(2, estadoId);
            psInsert.executeUpdate();

            ResultSet generated = psInsert.getGeneratedKeys();
            if (generated.next()) {
                return generated.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }
}
