package projetoLivraria.dao;

import projetoLivraria.model.Telefone;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class TelefoneDAO {
    public void inserir(Connection conn, Telefone t) throws Exception {

        String sql = "INSERT INTO telefone (cliente_id, tipo, ddd, numero) VALUES (?,?,?,?)";

        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setInt(1, t.getCliente());
        stmt.setString(2, t.getTipo());
        stmt.setString(3, t.getDdd());
        stmt.setString(4, t.getNumero());

        stmt.executeUpdate();
    }
}
