package projetoLivraria.service.validacao;

import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
import projetoLivraria.service.ClienteException;

import java.sql.Connection;
import java.util.regex.Pattern;

public class SenhaValidacao implements ValidacaoCliente {

    // Mínimo 8 chars, 1 maiúscula, 1 dígito, 1 especial
    private static final Pattern SENHA_FORTE = Pattern.compile(
            "^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$"
    );

    @Override
    public void validar(Connection conn, int idIgnorar,
                        Cliente cliente, Telefone telefone,
                        Endereco enderecoEntrega, Endereco enderecoCobranca)
            throws ClienteException {

        String senha = cliente.getSenha();

        // idIgnorar == -1 indica cadastro: senha é obrigatória
        if (senha == null || senha.isEmpty()) {
            if (idIgnorar == -1) {
                throw new ClienteException(ClienteException.Codigo.SENHA_FRACA,
                        "A senha é obrigatória.");
            }
            return; // edição: senha vazia significa "não alterar"
        }

        if (!SENHA_FORTE.matcher(senha).matches()) {
            throw new ClienteException(ClienteException.Codigo.SENHA_FRACA,
                    "A senha deve ter pelo menos 8 caracteres, uma letra maiúscula, " +
                            "um número e um caractere especial.");
        }
    }
}