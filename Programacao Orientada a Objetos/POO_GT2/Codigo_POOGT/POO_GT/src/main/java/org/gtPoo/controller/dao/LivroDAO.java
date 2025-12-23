package org.gtPoo.controller.dao;

import org.gtPoo.controller.ConexaoSQL;
import org.gtPoo.model.Ebook;
import org.gtPoo.model.Fisico;
import org.gtPoo.model.Livro;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LivroDAO {

    public void salvar(Livro l) {
        String tipo = (l instanceof Fisico) ? "FISICO" : "EBOOK";
        if (l.getId() == 0) {
            String sql = "INSERT INTO livro(titulo,isbn,autor,tipo) VALUES(?,?,?,?)";
            try (Connection c = ConexaoSQL.conectar();
                 PreparedStatement p = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                p.setString(1, l.getTitulo());
                p.setString(2, l.getIsbn());
                p.setString(3, l.getAutor());
                p.setString(4, tipo);
                p.executeUpdate();
                try (ResultSet rs = p.getGeneratedKeys()) {
                    if (rs.next()) l.setId(rs.getInt(1));
                }
            } catch (SQLException e) { e.printStackTrace(); }
        } else {
            String sql = "UPDATE livro SET titulo=?, isbn=?, autor=?, tipo=? WHERE id=?";
            try (Connection c = ConexaoSQL.conectar();
                 PreparedStatement p = c.prepareStatement(sql)) {
                p.setString(1, l.getTitulo());
                p.setString(2, l.getIsbn());
                p.setString(3, l.getAutor());
                p.setString(4, tipo);
                p.setInt(5, l.getId());
                p.executeUpdate();
            } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    public List<Livro> listarTodos() {
        List<Livro> lista = new ArrayList<>();
        String sql = "SELECT * FROM livro";
        try (Connection c = ConexaoSQL.conectar();
             PreparedStatement p = c.prepareStatement(sql);
             ResultSet rs = p.executeQuery()) {
            while (rs.next()) {
                String tipo = rs.getString("tipo");
                Livro l;
                if ("FISICO".equalsIgnoreCase(tipo)) {
                    l = new Fisico();
                } else {
                    l = new Ebook();
                }
                l.setId(rs.getInt("id"));
                l.setTitulo(rs.getString("titulo"));
                l.setIsbn(rs.getString("isbn"));
                l.setAutor(rs.getString("autor"));
                lista.add(l);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    public void excluir(Livro l) {
        String sql = "DELETE FROM livro WHERE id=?";
        try (Connection c = ConexaoSQL.conectar();
             PreparedStatement p = c.prepareStatement(sql)) {
            p.setInt(1, l.getId());
            p.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}