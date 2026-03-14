package service;

import projetoLivraria.dao.ClienteDAO;
import projetoLivraria.dao.ConexaoSQL;
import projetoLivraria.dao.EnderecoDAO;
import projetoLivraria.dao.TelefoneDAO;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;

import java.sql.Connection;

public class ClienteService {
    private ClienteDAO clienteDAO = new ClienteDAO();
    private TelefoneDAO telefoneDAO = new TelefoneDAO();
    private EnderecoDAO enderecoDAO = new EnderecoDAO();

    public void cadastrarCliente(Cliente c, Telefone t, Endereco e) throws Exception {

        Connection conn = ConexaoSQL.getInstance().getConnection();

        try {

            conn.setAutoCommit(false);

            int cliente = clienteDAO.inserir(conn, c);

            t.setCliente(cliente);
            telefoneDAO.inserir(conn, t);

            e.setCliente(cliente);
            enderecoDAO.inserir(conn, e);

            conn.commit();

        } catch (Exception e) {

            conn.rollback();
            throw e;

        } finally {

            conn.close();
        }
    }
}
