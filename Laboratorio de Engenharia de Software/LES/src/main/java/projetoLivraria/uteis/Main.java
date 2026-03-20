package projetoLivraria;

/*Projeto LES*/

import projetoLivraria.dao.ConexaoSQL;

public class Main {
    public static void main(String[] args) {
        ConexaoSQL.criarTabelasSeNaoExistirem();
    }
}