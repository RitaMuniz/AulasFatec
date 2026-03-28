package projetoLivraria.dao;

import projetoLivraria.model.Endereco;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnderecoDAO {

    public Endereco inserir(Connection conn, Endereco e) throws Exception {
        String sql = "INSERT INTO endereco (cliente_id, tipo_residencia, tipo_logradouro, logradouro, numero, cep, bairro, cidade_id, observacoes, tipo_endereco) VALUES (?,?,?,?,?,?,?,?,?,?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, e.getClienteId());
            stmt.setString(2, e.getTipoResidencia());
            stmt.setString(3, e.getTipoLogradouro());
            stmt.setString(4, e.getLogradouro());
            stmt.setString(5, e.getNumero());
            stmt.setString(6, e.getCep());
            stmt.setString(7, e.getBairro());
            stmt.setInt(8, e.getCidadeId());
            stmt.setString(9, e.getObservacoes());
            stmt.setString(10, e.getTipoEndereco());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    e.setId(rs.getInt(1));
                }
            }
        }
        return e;
    }

    public Endereco editar(Connection conn, Endereco e) throws Exception {
        String sql = "UPDATE endereco SET tipo_residencia=?, tipo_logradouro=?, logradouro=?, numero=?, cep=?, bairro=?, cidade_id=?, observacoes=?, tipo_endereco=? WHERE id=?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, e.getTipoResidencia());
            stmt.setString(2, e.getTipoLogradouro());
            stmt.setString(3, e.getLogradouro());
            stmt.setString(4, e.getNumero());
            stmt.setString(5, e.getCep());
            stmt.setString(6, e.getBairro());
            stmt.setInt(7, e.getCidadeId());
            stmt.setString(8, e.getObservacoes());
            stmt.setString(9, e.getTipoEndereco());
            stmt.setInt(10, e.getId());

            stmt.executeUpdate();
        }
        return e;
    }

    public void excluir(Connection conn, int id) throws Exception {
        String sql = "DELETE FROM endereco WHERE id=?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public List<Endereco> listarPorCliente(Connection conn, int clienteId) throws Exception {
        String sql = "SELECT * FROM endereco WHERE cliente_id=?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, clienteId);

            try (ResultSet rs = stmt.executeQuery()) {
                List<Endereco> lista = new ArrayList<>();
                while (rs.next()) {
                    lista.add(mapear(rs));
                }
                return lista;
            }
        }
    }

    public Endereco buscarPorId(Connection conn, int id) throws Exception {
        String sql = "SELECT * FROM endereco WHERE id=?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapear(rs);
                }
            }
        }
        return null;
    }

    private Endereco mapear(ResultSet rs) throws Exception {
        Endereco e = new Endereco();
        e.setId(rs.getInt("id"));
        e.setClienteId(rs.getInt("cliente_id"));
        e.setTipoResidencia(rs.getString("tipo_residencia"));
        e.setTipoLogradouro(rs.getString("tipo_logradouro"));
        e.setLogradouro(rs.getString("logradouro"));
        e.setNumero(rs.getString("numero"));
        e.setCep(rs.getString("cep"));
        e.setBairro(rs.getString("bairro"));
        e.setCidadeId(rs.getInt("cidade_id"));
        e.setObservacoes(rs.getString("observacoes"));
        e.setTipoEndereco(rs.getString("tipo_endereco"));
        return e;
    }
}