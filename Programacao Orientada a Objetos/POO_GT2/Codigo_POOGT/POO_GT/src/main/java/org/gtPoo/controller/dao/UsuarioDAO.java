package org.gtPoo.controller.dao;
import org.gtPoo.controller.ConexaoSQL;
import org.gtPoo.model.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public void salvar(Usuario u) {
        String sql = (u.getId() == 0)
                ? "INSERT INTO usuario(nome, email, telefone, numero_registro, tipo) VALUES(?,?,?,?,?)"
                : "UPDATE usuario SET nome=?, email=?, telefone=?, numero_registro=?, tipo=? WHERE id=?";
        try (Connection c = ConexaoSQL.conectar()) {
            if (u.getId() == 0) {
                try (PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, u.getNome());
                    ps.setString(2, u.getEmail());
                    ps.setString(3, u.getTelefone());
                    ps.setString(4, u.getNumeroRegistro());
                    ps.setString(5, u.getTipo());
                    ps.executeUpdate();
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) u.setId(rs.getInt(1));
                    }
                }
            } else {
                try (PreparedStatement ps = c.prepareStatement(sql)) {
                    ps.setString(1, u.getNome());
                    ps.setString(2, u.getEmail());
                    ps.setString(3, u.getTelefone());
                    ps.setString(4, u.getNumeroRegistro());
                    ps.setString(5, u.getTipo());
                    ps.setInt(6, u.getId());
                    ps.executeUpdate();
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Usuario> listarTodos() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuario";
        try (Connection c = ConexaoSQL.conectar();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email"));
                u.setTelefone(rs.getString("telefone"));
                u.setNumeroRegistro(rs.getString("numero_registro"));
                u.setTipo(rs.getString("tipo"));
                lista.add(u);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    public void excluir(Usuario u) {
        String sql = "DELETE FROM usuario WHERE id=?";
        try (Connection c = ConexaoSQL.conectar();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, u.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}