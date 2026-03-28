package projetoLivraria.service;

import projetoLivraria.dao.ClienteDAO;
import projetoLivraria.dao.EnderecoDAO;
import projetoLivraria.dao.TelefoneDAO;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
import projetoLivraria.service.validacao.*;
import projetoLivraria.uteis.ConexaoSQL;

import java.sql.Connection;
import java.util.List;

public class ClienteService {

    private final ClienteDAO clienteDAO   = new ClienteDAO();
    private final EnderecoDAO enderecoDAO = new EnderecoDAO();
    private final TelefoneDAO telefoneDAO = new TelefoneDAO();

    private final CpfUnicoValidacao   cpfUnicoValidacao   = new CpfUnicoValidacao(clienteDAO);
    private final EmailUnicoValidacao emailUnicoValidacao = new EmailUnicoValidacao(clienteDAO);

    // Ordem importa: validações sem banco antes das que abrem conexão.
    private List<ValidacaoCliente> strategiesCadastro() {
        return List.of(
                new NomeValidacao(),
                new CpfFormatoValidacao(),
                new SenhaValidacao(),
                new EnderecoValidacao(),
                cpfUnicoValidacao,
                emailUnicoValidacao
        );
    }

    private List<ValidacaoCliente> strategiesEdicao() {
        return List.of(
                new NomeValidacao(),
                new SenhaValidacao(),   // só valida se senha vier preenchida
                emailUnicoValidacao     // rejeita se e-mail já pertencer a outro cliente
        );
    }

    public Cliente cadastrarCliente(Cliente cliente, Telefone telefone,
                                    Endereco enderecoEntrega, Endereco enderecoCobranca)
            throws Exception {

        Connection conn = ConexaoSQL.getInstance().getConnection();
        try {
            conn.setAutoCommit(false);

            // Executa todas as strategies de cadastro
            executarValidacoes(strategiesCadastro(), conn, -1,
                    cliente, telefone, enderecoEntrega, enderecoCobranca);

            cliente = clienteDAO.inserir(conn, cliente);

            telefone.setClienteId(cliente.getId());
            telefoneDAO.inserir(conn, telefone);

            enderecoEntrega.setClienteId(cliente.getId());
            enderecoDAO.inserir(conn, enderecoEntrega);

            enderecoCobranca.setClienteId(cliente.getId());
            enderecoDAO.inserir(conn, enderecoCobranca);

            conn.commit();
            return cliente;

        } catch (ClienteException ce) {
            conn.rollback();
            throw ce;
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
            // idIgnorar = id do próprio cliente, evita falso positivo de unicidade
            executarValidacoes(strategiesEdicao(), conn, cliente.getId(),
                    cliente, null, null, null);
            return clienteDAO.editar(conn, cliente);
        } catch (ClienteException ce) {
            throw ce;
        } finally {
            conn.close();
        }
    }
    public void desativarCliente(int id) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { clienteDAO.desativar(conn, id); } finally { conn.close(); }
    }

    public void reativarCliente(int id) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { clienteDAO.reativar(conn, id); } finally { conn.close(); }
    }

    public Cliente buscarCliente(int id) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { return clienteDAO.buscarPorId(conn, id); } finally { conn.close(); }
    }

    public Cliente buscarClientePorEmail(String email) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { return clienteDAO.buscarPorEmail(conn, email); } finally { conn.close(); }
    }

    public List<Cliente> listarClientes() throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { return clienteDAO.listarTodos(conn); } finally { conn.close(); }
    }

    public List<Cliente> buscarClientes(String termo) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { return clienteDAO.buscarPorTermo(conn, termo); } finally { conn.close(); }
    }

    public Endereco adicionarEndereco(Endereco endereco) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { return enderecoDAO.inserir(conn, endereco); } finally { conn.close(); }
    }

    public Endereco editarEndereco(Endereco endereco) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { return enderecoDAO.editar(conn, endereco); } finally { conn.close(); }
    }

    public void excluirEndereco(int id) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { enderecoDAO.excluir(conn, id); } finally { conn.close(); }
    }

    public List<Endereco> listarEnderecos(int clienteId) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { return enderecoDAO.listarPorCliente(conn, clienteId); } finally { conn.close(); }
    }

    public Telefone adicionarTelefone(Telefone telefone) throws Exception {
        Connection conn = ConexaoSQL.getInstance().getConnection();
        try { return telefoneDAO.inserir(conn, telefone); } finally { conn.close(); }
    }

    private void executarValidacoes(List<ValidacaoCliente> strategies,
                                    Connection conn,
                                    int idIgnorar,
                                    Cliente cliente,
                                    Telefone telefone,
                                    Endereco enderecoEntrega,
                                    Endereco enderecoCobranca) throws Exception {
        for (ValidacaoCliente strategy : strategies) {
            strategy.validar(conn, idIgnorar, cliente, telefone, enderecoEntrega, enderecoCobranca);
        }
    }
}