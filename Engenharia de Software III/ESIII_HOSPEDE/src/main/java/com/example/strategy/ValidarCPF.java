package com.example.strategy;

import com.example.dominio.EntidadeDominio;
import com.example.model.Hospede;

public class ValidarCPF implements IStrategy {

    @Override
    public String processar(EntidadeDominio entidade) {

        if (!(entidade instanceof Hospede)) return null;

        Hospede h = (Hospede) entidade;
        if (h.getCpf() == null) return "CPF inválido";
        String cpf = h.getCpf();
        if (cpf.length() != 11) return "CPF inválido";
        return null;
    }
}
