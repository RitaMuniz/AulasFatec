package projetoLivraria.dao;

import projetoLivraria.model.Cliente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    public Cliente inserir(Connection conn, Cliente c) throws Exception {
        String sql = "INSERT INTO cliente (nome, genero, data_nascimento, cpf, email, senha, status) VALUES (?,?,?,?,?,?,?)";

        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setString(1, c.getNome());
        stmt.setString(2, c.getGenero());
        stmt.setDate(3, c.getDataNascimento());
        stmt.setString(4, c.getCpf());
        stmt.setString(5, c.getEmail());
        stmt.setString(6, c.getSenha());
        stmt.setString(7, "ATIVO");

        stmt.executeUpdate();

        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) {
            c.setId(rs.getInt(1));
        }
        return c;
    }

    public Cliente editar(Connection conn, Cliente c) throws Exception {
        String sql = "UPDATE cliente SET nome=?, genero=?, data_nascimento=?, email=? WHERE id=?";

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, c.getNome());
        stmt.setString(2, c.getGenero());
        stmt.setDate(3, c.getDataNascimento());
        stmt.setString(4, c.getEmail());
        stmt.setInt(5, c.getId());

        stmt.executeUpdate();
        return c;
    }

    public void desativar(Connection conn, int id) throws Exception {
        String sql = "UPDATE cliente SET status=? WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, "INATIVO");
        stmt.setInt(2, id);
        stmt.executeUpdate();
    }

    public void reativar(Connection conn, int id) throws Exception {
        String sql = "UPDATE cliente SET status=? WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, "ATIVO");
        stmt.setInt(2, id);
        stmt.executeUpdate();
    }

    public Cliente buscarPorId(Connection conn, int id) throws Exception {
        String sql = "SELECT * FROM cliente WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) return mapear(rs);
        return null;
    }

    public Cliente buscarPorEmail(Connection conn, String email) throws Exception {
        String sql = "SELECT * FROM cliente WHERE email=? AND status='ATIVO'";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) return mapear(rs);
        return null;
    }

    public List<Cliente> listarTodos(Connection conn) throws Exception {
        String sql = "SELECT * FROM cliente ORDER BY nome";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        List<Cliente> lista = new ArrayList<>();
        while (rs.next()) lista.add(mapear(rs));
        return lista;
    }

    // Busca por nome, email ou CPF (parcial, case-insensitive)
    public List<Cliente> buscarPorTermo(Connection conn, String termo) throws Exception {
        String sql = "SELECT * FROM cliente WHERE " +
                "LOWER(nome) LIKE ? OR LOWER(email) LIKE ? OR cpf LIKE ? " +
                "ORDER BY nome";
        String like = "%" + termo.toLowerCase() + "%";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, like);
        stmt.setString(2, like);
        stmt.setString(3, like);
        ResultSet rs = stmt.executeQuery();
        List<Cliente> lista = new ArrayList<>();
        while (rs.next()) lista.add(mapear(rs));
        return lista;
    }

    private Cliente mapear(ResultSet rs) throws Exception {
        Cliente c = new Cliente();
        c.setId(rs.getInt("id"));
        c.setNome(rs.getString("nome"));
        c.setGenero(rs.getString("genero"));
        c.setDataNascimento(rs.getDate("data_nascimento"));
        c.setCpf(rs.getString("cpf"));
        c.setEmail(rs.getString("email"));
        c.setSenha(rs.getString("senha"));
        c.setStatus(rs.getString("status"));
        return c;
    }
}