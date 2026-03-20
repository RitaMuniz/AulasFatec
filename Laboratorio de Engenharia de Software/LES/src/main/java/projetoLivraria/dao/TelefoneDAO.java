package projetoLivraria.dao;

import projetoLivraria.model.Telefone;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TelefoneDAO {

    public Telefone inserir(Connection conn, Telefone t) throws Exception {
        String sql = "INSERT INTO telefone (cliente_id, tipo, ddd, numero) VALUES (?,?,?,?)";

        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setInt(1, t.getClienteId());
        stmt.setString(2, t.getTipo());
        stmt.setString(3, t.getDdd());
        stmt.setString(4, t.getNumero());

        stmt.executeUpdate();

        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) {
            t.setId(rs.getInt(1));
        }
        return t;
    }

    public Telefone editar(Connection conn, Telefone t) throws Exception {
        String sql = "UPDATE telefone SET tipo=?, ddd=?, numero=? WHERE id=?";

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, t.getTipo());
        stmt.setString(2, t.getDdd());
        stmt.setString(3, t.getNumero());
        stmt.setInt(4, t.getId());

        stmt.executeUpdate();
        return t;
    }

    public void excluir(Connection conn, int id) throws Exception {
        String sql = "DELETE FROM telefone WHERE id=?";

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public List<Telefone> listarPorCliente(Connection conn, int clienteId) throws Exception {
        String sql = "SELECT * FROM telefone WHERE cliente_id=?";

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, clienteId);

        ResultSet rs = stmt.executeQuery();
        List<Telefone> lista = new ArrayList<>();
        while (rs.next()) {
            lista.add(mapear(rs));
        }
        return lista;
    }

    private Telefone mapear(ResultSet rs) throws Exception {
        Telefone t = new Telefone();
        t.setId(rs.getInt("id"));
        t.setClienteId(rs.getInt("cliente_id"));
        t.setTipo(rs.getString("tipo"));
        t.setDdd(rs.getString("ddd"));
        t.setNumero(rs.getString("numero"));
        return t;
    }
}