import java.awt.*;
import java.util.ArrayList;
import java.util.List;

/*
* ex1: Crie uma classe Pessoa com os atributos nome e idade.
*      Implemente um método que exibe esses dados.
* ex3: Torne os atributos nome e idade privados e crie métodos getters e setters.
* ex4: Crie um construtor para a classe Pessoa.
* ex7: Crie uma interface Trabalhavel com método trabalhar().
*      Faça Pessoa implementá-la.
*/
public class Pessoa implements Trabalhavel {

    //ex3
    private String nome;
    private String idade;

    //ex4
    public Pessoa(String nome, String idade){
        this.nome = nome;
        this.idade = idade;
    }

    public void exibaPessoa() {
        System.out.printf("""
                Olá %s
                Idade: %s""",
                nome, idade);
    }

    //ex7
    public void trabalhar() {
        System.out.println("Pessoa está trabalhando");
    }
    //ex3
    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getIdade() {
        return idade;
    }

    public void setIdade(String idade) {
        this.idade = idade;
    }
}