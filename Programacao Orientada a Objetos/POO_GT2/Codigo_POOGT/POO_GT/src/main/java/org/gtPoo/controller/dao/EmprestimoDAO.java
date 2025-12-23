package org.gtPoo.controller.dao;

import org.gtPoo.controller.ConexaoSQL;
import org.gtPoo.model.Emprestimo;
import org.gtPoo.model.Livro;
import org.gtPoo.model.Usuario;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class EmprestimoDAO {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    private LivroDAO livroDAO = new LivroDAO();

    public void salvar(Emprestimo e) {
        if (e.getId() == 0) {
            String sql = "INSERT INTO emprestimo(usuario_id, livro_id, data_retirada, data_devolucao) VALUES(?,?,?,?)";
            try (Connection c = ConexaoSQL.conectar();
                 PreparedStatement p = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                p.setInt(1, e.getUsuario().getId());
                p.setInt(2, e.getLivro().getId());
                p.setString(3, e.getDataRetirada() != null ? e.getDataRetirada().toString() : null);
                p.setString(4, e.getDataDevolucao() != null ? e.getDataDevolucao().toString() : null);
                p.executeUpdate();
                try (ResultSet rs = p.getGeneratedKeys()) {
                    if (rs.next()) e.setId(rs.getInt(1));
                }
            } catch (SQLException ex) { ex.printStackTrace(); }
        } else {
            String sql = "UPDATE emprestimo SET usuario_id=?, livro_id=?, data_retirada=?, data_devolucao=? WHERE id=?";
            try (Connection c = ConexaoSQL.conectar();
                 PreparedStatement p = c.prepareStatement(sql)) {
                p.setInt(1, e.getUsuario().getId());
                p.setInt(2, e.getLivro().getId());
                p.setString(3, e.getDataRetirada() != null ? e.getDataRetirada().toString() : null);
                p.setString(4, e.getDataDevolucao() != null ? e.getDataDevolucao().toString() : null);
                p.setInt(5, e.getId());
                p.executeUpdate();
            } catch (SQLException ex) { ex.printStackTrace(); }
        }
    }

    public List<Emprestimo> listarTodos() {
        List<Emprestimo> lista = new ArrayList<>();
        String sql = "SELECT * FROM emprestimo";
        try (Connection c = ConexaoSQL.conectar();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Emprestimo e = new Emprestimo();
                e.setId(rs.getInt("id"));
                int uid = rs.getInt("usuario_id");
                int lid = rs.getInt("livro_id");
                Usuario u = null;
                for (Usuario uu : usuarioDAO.listarTodos()) if (uu.getId() == uid) { u = uu; break; }
                Livro l = null;
                for (Livro ll : livroDAO.listarTodos()) if (ll.getId() == lid) { l = ll; break; }

                e.setUsuario(u);
                e.setLivro(l);

                String dr = rs.getString("data_retirada");
                String dd = rs.getString("data_devolucao");
                e.setDataRetirada(dr != null ? LocalDate.parse(dr) : null);
                e.setDataDevolucao(dd != null ? LocalDate.parse(dd) : null);
                lista.add(e);
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return lista;
    }

    public void excluir(Emprestimo e) {
        String sql = "DELETE FROM emprestimo WHERE id=?";
        try (Connection c = ConexaoSQL.conectar();
             PreparedStatement p = c.prepareStatement(sql)) {
            p.setInt(1, e.getId());
            p.executeUpdate();
        } catch (SQLException ex) { ex.printStackTrace(); }
    }
}