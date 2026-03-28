package projetoLivraria.service.validacao;

import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
import projetoLivraria.service.ClienteException;

import java.sql.Connection;

public class CpfFormatoValidacao implements ValidacaoCliente {

    @Override
    public void validar(Connection conn, int idIgnorar,
                        Cliente cliente, Telefone telefone,
                        Endereco enderecoEntrega, Endereco enderecoCobranca)
            throws ClienteException {

        String cpf = cliente.getCpf();

        if (cpf == null) {
            throw new ClienteException(ClienteException.Codigo.CPF_INVALIDO,
                    "CPF não informado.");
        }

        String d = cpf.replaceAll("[^0-9]", "");

        if (d.length() != 11) {
            throw new ClienteException(ClienteException.Codigo.CPF_INVALIDO,
                    "CPF deve conter 11 dígitos.");
        }

        if (d.chars().distinct().count() == 1) {
            throw new ClienteException(ClienteException.Codigo.CPF_INVALIDO,
                    "CPF inválido.");
        }

        // Primeiro dígito
        int soma = 0;
        for (int i = 0; i < 9; i++) soma += Character.getNumericValue(d.charAt(i)) * (10 - i);
        int r1 = 11 - (soma % 11);
        int d1 = (r1 >= 10) ? 0 : r1;

        // Segundo dígito
        soma = 0;
        for (int i = 0; i < 10; i++) soma += Character.getNumericValue(d.charAt(i)) * (11 - i);
        int r2 = 11 - (soma % 11);
        int d2 = (r2 >= 10) ? 0 : r2;

        if (d1 != Character.getNumericValue(d.charAt(9)) ||
                d2 != Character.getNumericValue(d.charAt(10))) {
            throw new ClienteException(ClienteException.Codigo.CPF_INVALIDO,
                    "CPF inválido. Verifique os dígitos informados.");
        }
    }
}