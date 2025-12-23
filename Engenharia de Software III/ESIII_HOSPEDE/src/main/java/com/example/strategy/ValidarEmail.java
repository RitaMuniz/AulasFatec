package com.example.strategy;

import com.example.dominio.EntidadeDominio;
import com.example.model.Hospede;

public class ValidarEmail implements IStrategy {

    public String processar(EntidadeDominio entidade) {

        if (!(entidade instanceof Hospede)) return null;

        Hospede h = (Hospede) entidade;
        if (h.getEmail() == null) return "Email inválido";
        String email = h.getEmail();
        if (!email.contains("@") || !email.contains(".")) return "Email inválido";
        return null;

    }
}
