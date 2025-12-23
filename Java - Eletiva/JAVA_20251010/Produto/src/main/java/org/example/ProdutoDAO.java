package org.example;

import java.util.List;

/*
5. Criação da Entidade e Interface DAO:
Crie a classe Produto (POJO) com os atributos (id, nome, preco, estoque) e crie a Interface ProdutoDAO com a assinatura dos métodos:
public void salvar(Produto produto);
e public List<Produto> buscarTodos();.
*/

public interface ProdutoDAO {

    public void salvar(Produto produto);
    public List<Produto> buscarTodos();
}
