package com.example.dao;

import com.example.model.Endereco;
import com.example.model.Cidade;
import com.example.model.Estado;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnderecoDAO {

    private final ConexaoSQL conexao = ConexaoSQL.getInstance();

    public Endereco salvar(Endereco e) throws Exception {
        String sql = """
            INSERT INTO endereco
            (logradouro, numero, complemento, bairro, cidade_id, estado_id, hospede_id)
            VALUES (?,?,?,?,?,?,?);
        """;

        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, e.getLogradouro());
            ps.setString(2, e.getNumero());
            ps.setString(3, e.getComplemento());
            ps.setString(4, e.getBairro());
            ps.setLong(5, e.getCidade().getId());
            ps.setLong(6, e.getEstado().getId());
            ps.setLong(7, e.getHospede().getId());

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) e.setId(rs.getLong(1));
            }
        }
        return e;
    }

    public void excluirPorHospede(Long idHospede) throws Exception {
        String sql = "DELETE FROM endereco WHERE hospede_id=?;";
        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setLong(1, idHospede);
            ps.executeUpdate();
        }
    }

    public List<Endereco> listarPorHospede(Long idHospede) throws Exception {

        String sql = """
            SELECT e.id, e.logradouro, e.numero, e.complemento, e.bairro,
                   c.id AS cidade_id, c.nome AS cidade_nome,
                   es.id AS estado_id, es.nome AS estado_nome
            FROM endereco e
            JOIN cidade c ON c.id = e.cidade_id
            JOIN estado es ON es.id = e.estado_id
            WHERE e.hospede_id = ?;
        """;

        List<Endereco> lista = new ArrayList<>();

        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setLong(1, idHospede);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Endereco e = new Endereco();
                    e.setId(rs.getLong("id"));
                    e.setLogradouro(rs.getString("logradouro"));
                    e.setNumero(rs.getString("numero"));
                    e.setComplemento(rs.getString("complemento"));
                    e.setBairro(rs.getString("bairro"));

                    Cidade cidade = new Cidade();
                    cidade.setId(rs.getLong("cidade_id"));
                    cidade.setNome(rs.getString("cidade_nome"));

                    Estado estado = new Estado();
                    estado.setId(rs.getLong("estado_id"));
                    estado.setNome(rs.getString("estado_nome"));

                    e.setCidade(cidade);
                    e.setEstado(estado);

                    lista.add(e);
                }
            }
        }
        return lista;
    }
}
