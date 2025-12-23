package com.example.strategy;

import com.example.dominio.EntidadeDominio;
import com.example.model.Hospede;

public class ValidarDadosObrigatorios implements IStrategy {

    @Override
    public String processar(EntidadeDominio entidade) {

        if (!(entidade instanceof Hospede)) return null;

        Hospede h = (Hospede) entidade;
        if (h.getNome() == null || h.getNome().trim().isEmpty()) return "Nome obrigatório";
        if (h.getEmail() == null || h.getEmail().trim().isEmpty()) return "Email obrigatório";
        if (h.getCpf() == null || h.getCpf().trim().isEmpty()) return "CPF obrigatório";
        if (h.getDataNascimento() == null || h.getDataNascimento().trim().isEmpty()) return "Data obrigatória";
        if (h.getTelefone() == null || h.getTelefone().trim().isEmpty()) return "Telefone Obrigatório";
        //if (h.getEnderecos() == null || h.getEnderecos().isEmpty()) return "Endereço Obrigatorio";
        return null;
    }
}
