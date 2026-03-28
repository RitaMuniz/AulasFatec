package projetoLivraria.service.validacao;

import projetoLivraria.model.Cliente;
import projetoLivraria.model.Endereco;
import projetoLivraria.model.Telefone;
import projetoLivraria.service.ClienteException;

import java.sql.Connection;

/**
 * Strategy de validação de Cliente.
 *
 * Cada implementação encapsula UMA regra de negócio.
 * O ClienteService monta a lista de strategies e itera sobre elas.
 *
 * @param conn  conexão ativa (pode ser null para validações sem banco)
 * @param idIgnorar  id do próprio cliente em edições (evita falso positivo de unicidade);
 *                   passe -1 no cadastro
 */
public interface ValidacaoCliente {
    void validar(Connection conn,
                 int idIgnorar,
                 Cliente cliente,
                 Telefone telefone,
                 Endereco enderecoEntrega,
                 Endereco enderecoCobranca) throws ClienteException, Exception;
}