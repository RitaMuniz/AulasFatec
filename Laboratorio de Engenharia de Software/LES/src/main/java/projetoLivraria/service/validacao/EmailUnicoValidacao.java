package projetoLivraria.service.validacao;

import projetoLivraria.dao.ClienteDAO;
import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
import projetoLivraria.service.ClienteException;

import java.sql.Connection;

public class EmailUnicoValidacao implements ValidacaoCliente {

    private final ClienteDAO clienteDAO;

    public EmailUnicoValidacao(ClienteDAO clienteDAO) {
        this.clienteDAO = clienteDAO;
    }

    @Override
    public void validar(Connection conn, int idIgnorar,
                        Cliente cliente, Telefone telefone,
                        Endereco enderecoEntrega, Endereco enderecoCobranca)
            throws Exception {

        Cliente existente = clienteDAO.buscarPorEmail(conn, cliente.getEmail());
        if (existente != null && existente.getId() != idIgnorar) {
            throw new ClienteException(ClienteException.Codigo.EMAIL_JA_CADASTRADO,
                    "Este e-mail já está cadastrado.");
        }
    }
}