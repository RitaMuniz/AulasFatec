package com.example.dao;

import com.example.model.Hospede;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class HospedeDAO implements IDAO<Hospede> {
    private ConexaoSQL conexao = ConexaoSQL.getInstance();

    @Override
    public Hospede salvar(Hospede h) throws Exception {
        String sql = "INSERT INTO hospede(nome, cpf, email, telefone, celular, data_nascimento ,senha, ativo) VALUES(?, ?, ?, ?, ?, ?, ?, ?);";
        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, h.getNome());
            ps.setString(2, h.getCpf());
            ps.setString(3, h.getEmail());
            ps.setString(4, h.getTelefone());
            ps.setString(5, h.getCelular());
            ps.setString(6, h.getDataNascimento());
            ps.setString(7, h.getSenha());
            ps.setInt(8, h.isAtivo() ? 1 : 0);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) h.setId(rs.getLong(1));
            }
        }

        EnderecoDAO enderecoDAO = new EnderecoDAO();
        if (h.getEnderecos() != null) {
            for (var end : h.getEnderecos()) {
                end.setHospede(h);
                enderecoDAO.salvar(end);
            }
        }
        return h;
    }

    @Override
    public Hospede alterar(Hospede h) throws Exception {

        String sql = "UPDATE hospede SET nome = ?, cpf = ?, email = ?, telefone = ?, celular =?, data_nascimento = ?, senha = ?, ativo = ? WHERE id = ?;";

        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, h.getNome());
            ps.setString(2, h.getCpf());
            ps.setString(3, h.getEmail());
            ps.setString(4, h.getTelefone());
            ps.setString(5, h.getCelular());
            ps.setString(6, h.getDataNascimento());
            ps.setString(7, h.getSenha());
            ps.setInt(8, h.isAtivo() ? 1 : 0);
            ps.setLong(9, h.getId());
            ps.executeUpdate();
        }

        EnderecoDAO enderecoDAO = new EnderecoDAO();
        enderecoDAO.excluirPorHospede(h.getId());

        if (h.getEnderecos() != null) {
            for (var end : h.getEnderecos()) {
                end.setHospede(h);
                enderecoDAO.salvar(end);
            }
        }
        return h;
    }

    @Override
    public void excluir(Long id) throws Exception {

        String sql = "DELETE FROM hospede WHERE id = ?;";

        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public Hospede buscarPorId(Long id) throws Exception {

        String sql = "SELECT * FROM hospede WHERE id = ?";
        Hospede h = null;

        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setLong(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    h = new Hospede();
                    h.setId(rs.getLong("id"));
                    h.setNome(rs.getString("nome"));
                    h.setCpf(rs.getString("cpf"));
                    h.setEmail(rs.getString("email"));
                    h.setTelefone(rs.getString("telefone"));
                    h.setCelular(rs.getString("celular"));
                    h.setDataNascimento(rs.getString("data_nascimento"));
                    h.setSenha(rs.getString("senha"));
                    h.setAtivo(rs.getInt("ativo") == 1);
                }
            }
        }

        if (h != null) {
            EnderecoDAO enderecoDAO = new EnderecoDAO();
            h.setEnderecos(enderecoDAO.listarPorHospede(h.getId()));
        }
        return h;
    }

    @Override
    public List<Hospede> listarTodos() throws Exception {

        String sql = "SELECT * FROM hospede";
        List<Hospede> lista = new ArrayList<>();

        try (Connection c = conexao.getConnection();

             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Hospede h = new Hospede();
                h.setId(rs.getLong("id"));
                h.setNome(rs.getString("nome"));
                h.setCpf(rs.getString("cpf"));
                h.setEmail(rs.getString("email"));
                h.setTelefone(rs.getString("telefone"));
                h.setCelular(rs.getString("celular"));
                h.setDataNascimento(rs.getString("data_nascimento"));
                h.setSenha(rs.getString("senha"));
                h.setAtivo(rs.getInt("ativo") == 1);

                EnderecoDAO enderecoDAO = new EnderecoDAO();
                h.setEnderecos(enderecoDAO.listarPorHospede(h.getId()));
                lista.add(h);
            }
        }
        return lista;
    }

    public List<Hospede> buscarComFiltro(String nome, String cpf, String email, String telefone) throws Exception {
        StringBuilder sb = new StringBuilder("SELECT * FROM hospede WHERE 1=1 ");
        List<Object> params = new ArrayList<>();
        if (nome != null && !nome.isBlank()) {
            sb.append(" AND lower(nome) LIKE ? ");
            params.add("%" + nome.toLowerCase() + "%");
        }
        if (cpf != null && !cpf.isBlank()) {
            sb.append(" AND cpf LIKE ? ");
            params.add("%" + cpf + "%");
        }
        if (email != null && !email.isBlank()) {
            sb.append(" AND lower(email) LIKE ? ");
            params.add("%" + email.toLowerCase() + "%");
        }
        if (telefone != null && !telefone.isBlank()) {
            sb.append(" AND telefone LIKE ? ");
            params.add("%" + telefone + "%");
        }

        try (Connection c = conexao.getConnection();
             PreparedStatement ps = c.prepareStatement(sb.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            try (ResultSet rs = ps.executeQuery()) {
                List<Hospede> lista = new ArrayList<>();
                while (rs.next()) {
                    Hospede h = new Hospede();
                    h.setId(rs.getLong("id"));
                    h.setNome(rs.getString("nome"));
                    h.setCpf(rs.getString("cpf"));
                    h.setEmail(rs.getString("email"));
                    h.setTelefone(rs.getString("telefone"));
                    h.setCelular(rs.getString("celular"));
                    h.setDataNascimento(rs.getString("data_nascimento"));
                    h.setSenha(rs.getString("senha"));
                    h.setAtivo(rs.getInt("ativo") == 1);

                    EnderecoDAO enderecoDAO = new EnderecoDAO();
                    h.setEnderecos(enderecoDAO.listarPorHospede(h.getId()));
                    lista.add(h);
                }
                return lista;
            }
        }
    }
}
