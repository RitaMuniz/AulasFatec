package projetoLivraria.dao;

import projetoLivraria.model.Admin;

import java.sql.*;

public class AdminDAO {

    public Admin buscarPorEmail(Connection conn, String email) throws Exception {
        String sql = "SELECT * FROM admin WHERE email=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            Admin a = new Admin();
            a.setId(rs.getInt("id"));
            a.setNome(rs.getString("nome"));
            a.setEmail(rs.getString("email"));
            a.setSenha(rs.getString("senha"));
            return a;
        }
        return null;
    }
}
