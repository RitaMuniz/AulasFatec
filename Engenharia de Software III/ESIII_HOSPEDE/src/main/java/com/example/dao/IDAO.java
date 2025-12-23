package com.example.dao;

import com.example.dominio.EntidadeDominio;

import java.util.List;

public interface IDAO <T extends EntidadeDominio> {

    T salvar(T obj) throws Exception;
    T alterar(T obj) throws Exception;
    void excluir(Long id) throws Exception;
    T buscarPorId(Long id) throws Exception;
    List<T> listarTodos() throws Exception;
}
