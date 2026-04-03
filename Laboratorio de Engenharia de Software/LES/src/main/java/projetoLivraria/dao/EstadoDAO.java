package projetoLivraria.dao;

import projetoLivraria.model.Estado;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EstadoDAO {

    public List<Estado> listar() {
        List<Estado> lista = new ArrayList<>();

        try (Connection conn = ConexaoSQL.getInstance().getConnection()) {
            String sql = "SELECT * FROM estado";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Estado e = new Estado();
                e.setId(rs.getInt("id"));
                e.setNome(rs.getString("nome"));
                lista.add(e);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
}
