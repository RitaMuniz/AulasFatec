package com.example.dao;

import com.example.model.Cidade;
import com.example.model.Estado;

import java.sql.*;

public class CidadeDAO {

    private final ConexaoSQL conexao = ConexaoSQL.getInstance();

    public Cidade salvar(Cidade c) throws Exception {
        String sql = "INSERT INTO cidade (nome, estado_id) VALUES (?,?);";
        try (Connection con = conexao.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, c.getNome());
            ps.setLong(2, c.getEstado().getId());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) c.setId(rs.getLong(1));
            }
        }
        return c;
    }

    public Cidade buscarPorNomeEEstado(String nome, Estado estado) throws Exception {
        String sql = "SELECT id, nome FROM cidade WHERE lower(nome)=lower(?) AND estado_id=? LIMIT 1;";
        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, nome);
            ps.setLong(2, estado.getId());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Cidade cdd = new Cidade();
                    cdd.setId(rs.getLong("id"));
                    cdd.setNome(rs.getString("nome"));
                    cdd.setEstado(estado);
                    return cdd;
                }
            }
        }
        return null;
    }

    public Cidade buscarPorNomeEEstadoOuCriar(String nome, Estado estado) throws Exception {
        if (nome == null || nome.isBlank() || estado == null) return null;

        Cidade c = buscarPorNomeEEstado(nome, estado);
        if (c != null) return c;

        Cidade nova = new Cidade();
        nova.setNome(nome);
        nova.setEstado(estado);

        return salvar(nova);
    }
}
