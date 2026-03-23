package projetoLivraria.service;

import projetoLivraria.dao.ClienteDAO;
import projetoLivraria.dao.EnderecoDAO;
import projetoLivraria.dao.TelefoneDAO;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.Connection;
import java.util.List;

public class ClienteService {

    private final ClienteDAO clienteDAO = new ClienteDAO();
    private final EnderecoDAO enderecoDAO = new EnderecoDAO();
    private final TelefoneDAO telefoneDAO = new TelefoneDAO();

    public Cliente cadastrarCliente(Cliente cliente, Telefone telefone, Endereco endereco) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            conn.setAutoCommit(false);

            cliente = clienteDAO.inserir(conn, cliente);

            telefone.setClienteId(cliente.getId());
            telefoneDAO.inserir(conn, telefone);

            endereco.setClienteId(cliente.getId());
            enderecoDAO.inserir(conn, endereco);

            conn.commit();
            return cliente;

        } catch (Exception e) {
            conn.rollback();
            throw e;
        } finally {
            conn.setAutoCommit(true);
            conn.close();
        }
    }

    public Cliente editarCliente(Cliente cliente) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            return clienteDAO.editar(conn, cliente);
        } finally {
            conn.close();
        }
    }

    public void desativarCliente(int id) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            clienteDAO.desativar(conn, id);
        } finally {
            conn.close();
        }
    }

    public void reativarCliente(int id) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            clienteDAO.reativar(conn, id);
        } finally {
            conn.close();
        }
    }

    public Cliente buscarCliente(int id) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            return clienteDAO.buscarPorId(conn, id);
        } finally {
            conn.close();
        }
    }

    public Cliente buscarClientePorEmail(String email) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            return clienteDAO.buscarPorEmail(conn, email);
        } finally {
            conn.close();
        }
    }

    public List<Cliente> listarClientes() throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            return clienteDAO.listarTodos(conn);
        } finally {
            conn.close();
        }
    }

    public List<Cliente> buscarClientes(String termo) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            return clienteDAO.buscarPorTermo(conn, termo);
        } finally {
            conn.close();
        }
    }

    public Endereco adicionarEndereco(Endereco endereco) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            return enderecoDAO.inserir(conn, endereco);
        } finally {
            conn.close();
        }
    }

    public Endereco editarEndereco(Endereco endereco) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            return enderecoDAO.editar(conn, endereco);
        } finally {
            conn.close();
        }
    }

    public void excluirEndereco(int id) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            enderecoDAO.excluir(conn, id);
        } finally {
            conn.close();
        }
    }

    public List<Endereco> listarEnderecos(int clienteId) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            return enderecoDAO.listarPorCliente(conn, clienteId);
        } finally {
            conn.close();
        }
    }

    public Telefone adicionarTelefone(Telefone telefone) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            return telefoneDAO.inserir(conn, telefone);
        } finally {
            conn.close();
        }
    }
}