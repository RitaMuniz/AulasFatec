package projetoLivraria.service.validacao;

import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
import projetoLivraria.service.ClienteException;

import java.sql.Connection;

public class EnderecoValidacao implements ValidacaoCliente {

    @Override
    public void validar(Connection conn, int idIgnorar,
                        Cliente cliente, Telefone telefone,
                        Endereco enderecoEntrega, Endereco enderecoCobranca)
            throws ClienteException {

        if (enderecoEntrega == null
                || enderecoEntrega.getLogradouro() == null
                || enderecoEntrega.getLogradouro().trim().isEmpty()) {
            throw new ClienteException(ClienteException.Codigo.ENDERECO_ENTREGA_AUSENTE,
                    "É obrigatório informar um endereço de entrega.");
        }

        if (enderecoCobranca == null
                || enderecoCobranca.getLogradouro() == null
                || enderecoCobranca.getLogradouro().trim().isEmpty()) {
            throw new ClienteException(ClienteException.Codigo.ENDERECO_COBRANCA_AUSENTE,
                    "É obrigatório informar um endereço de cobrança.");
        }
    }
}