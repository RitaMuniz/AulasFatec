package projetoLivraria.service.validacao;

import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
import projetoLivraria.service.ClienteException;

import java.sql.Connection;

public class NomeValidacao implements ValidacaoCliente {

    @Override
    public void validar(Connection conn, int idIgnorar,
                        Cliente cliente, Telefone telefone,
                        Endereco enderecoEntrega, Endereco enderecoCobranca)
            throws ClienteException {

        String nome = cliente.getNome();
        if (nome == null || nome.trim().length() < 3) {
            throw new ClienteException(
                    ClienteException.Codigo.NOME_INVALIDO,
                    "O nome completo deve ter pelo menos 3 caracteres."
            );
        }
    }
}