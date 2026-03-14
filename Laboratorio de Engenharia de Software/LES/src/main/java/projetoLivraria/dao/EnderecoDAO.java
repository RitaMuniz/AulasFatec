package projetoLivraria.dao;

import projetoLivraria.model.Endereco;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class EnderecoDAO {
    public void inserir(Connection conn, Endereco e) throws Exception {

        String sql = "INSERT INTO endereco (cliente_id, logradouro, numero, bairro, cep, cidade_id) VALUES (?,?,?,?,?,?)";

        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setInt(1, e.getCliente());
        stmt.setString(2, e.getLogradouro());
        stmt.setString(3, e.getNumero());
        stmt.setString(4, e.getBairro());
        stmt.setString(5, e.getCep());
        stmt.setInt(6, e.getCidade());

        stmt.executeUpdate();
    }
}
