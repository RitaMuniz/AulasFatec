package projetoLivraria.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class CupomDAO {

    public void marcarComoUsado(int cupomId, Connection con) throws Exception {

        String sql = "UPDATE cupom SET status = 'USADO' WHERE id = ?";

        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setInt(1, cupomId);
        stmt.executeUpdate();
    }
}