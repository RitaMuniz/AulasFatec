import java.util.ArrayList;
import java.util.List;

/*
* ex2: Instancie a classe Pessoa no método main e exiba seus dados.
* ex19: Crie uma lista de objetos Pessoa e percorra com for-each.
* ex20: Demonstre o uso de instanceof para verificar tipo de objeto.
*
* 5 INSTANCIE UM OBJETO DA CLASSE PIZZA QUE SEJA RODIZIO E QUE CUSTE R$70,00
* 6 INSTANCIE UM OBJETO DA CLASSE PASTEL QUE SEJA DO SABOR CARNE COM QUEIJO , TAMANHO INSANAMENTE GRANDE E QUE CUSTE R$10,00
*/
public class Main {

    public static void main(String[] args) {

        //ex2
        Pessoa pessoa = new Pessoa("Pessoa 1", "100");
        Aluno aluno = new Aluno("Pessoa2", "30", "fmc187");
        pessoa.exibaPessoa();
        aluno.exibirDados();

        //ex19
        List<Pessoa> pessoas = new ArrayList<>();
        pessoas.add(new Pessoa("Carlota", "52"));
        pessoas.add(new Pessoa("Gilberto", "25"));

        for(Pessoa p : pessoas) {
            p.exibaPessoa();
        }

        //ex20
        Salgado s = new Pizza("M", "Mussarela", 25.90, false);
        if (s instanceof Pastel) {
            System.out.println("É um aluno.");
        }

        //5
        Pizza calabreza = new Pizza("G", "calabreza", 70.00, true);
        calabreza.exibePizza();

        //6
        Pastel carneQueijo = new Pastel("Insanamente Grande", "Carne e Queijo", 10.00);
        carneQueijo.exibePastel();
    }
}