package com.example.strategy;

import com.example.dominio.EntidadeDominio;

public interface IStrategy {

    String processar(EntidadeDominio entidade);

}
