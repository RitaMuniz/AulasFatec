package projetoLivraria.dao;

import projetoLivraria.model.Bandeira;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BandeiraDAO {

    public List<Bandeira> listarTodas(Connection conn) throws Exception {
        String sql = "SELECT * FROM bandeira ORDER BY nome";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                List<Bandeira> lista = new ArrayList<>();
                while (rs.next()) {
                    Bandeira b = new Bandeira();
                    b.setId(rs.getInt("id"));
                    b.setNome(rs.getString("nome"));
                    lista.add(b);
                }
                return lista;
            }
        }
    }
}