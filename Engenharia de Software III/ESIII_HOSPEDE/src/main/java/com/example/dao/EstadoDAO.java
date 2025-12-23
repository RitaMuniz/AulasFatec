package com.example.dao;

import com.example.model.Estado;

import java.sql.*;

public class EstadoDAO {

    private final ConexaoSQL conexao = ConexaoSQL.getInstance();

    public Estado salvar(Estado e) throws Exception {
        String sql = "INSERT INTO estado (nome) VALUES (?);";
        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, e.getNome());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) e.setId(rs.getLong(1));
            }
        }
        return e;
    }

    public Estado buscarPorNome(String nome) throws Exception {
        String sql = "SELECT id, nome FROM estado WHERE lower(nome)=lower(?) LIMIT 1;";
        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, nome);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Estado e = new Estado();
                    e.setId(rs.getLong("id"));
                    e.setNome(rs.getString("nome"));
                    return e;
                }
            }
        }
        return null;
    }

    public Estado buscarPorNomeOuCriar(String nome) throws Exception {
        if (nome == null || nome.isBlank()) return null;

        Estado e = buscarPorNome(nome);
        if (e != null) return e;

        Estado novo = new Estado();
        novo.setNome(nome);
        return salvar(novo);
    }
}
