/*
* ex5: Crie uma classe Aluno que herda de Pessoa e tenha um atributo matricula
* ex6: Implemente polimorfismo sobrescrevendo o método exibirDados() na classe Aluno.
*/
public class Aluno extends Pessoa {

    private String matricula;

    public Aluno(String nome, String idade, String matricula) {
        super(nome, idade);
        this.matricula = matricula;
    }

    public String getMatricula() {
        return matricula;
    }

    //ex6
    public void exibirDados() {
        super.exibaPessoa();
        System.out.println("Matricula:" + matricula);
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
}