package projetoLivraria.dao;

import projetoLivraria.model.Cliente;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
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
        stmt.setBoolean(7, true);

        stmt.executeUpdate();

        ResultSet rs = stmt.getGeneratedKeys();
        rs.next();

        return rs.getInt(1);
    }

    public Cliente editar(Cliente c) throws Exception {
        String sql = "";

        return c;

    }

    public Cliente desativar(Cliente c) throws Exception {
        String sql = "";

        return c;

    }

    public List<Cliente> listarTodos() throws Exception {
        String sql = "";
        List<Cliente> lista = new ArrayList<>();

        return lista;
    }

}
