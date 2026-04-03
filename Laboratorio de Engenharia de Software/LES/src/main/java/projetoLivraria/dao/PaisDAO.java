package projetoLivraria.dao;

import projetoLivraria.model.Pais;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PaisDAO {

    public List<Pais> listar() {
        List<Pais> lista = new ArrayList<>();

        try (Connection conn = ConexaoSQL.getInstance().getConnection()) {
            String sql = "SELECT * FROM pais";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Pais p = new Pais();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}
