/*
* ex14: Crie Gerente que herda de Funcionario e tem bônus de 20%.
*/
public class Gerente extends Funcionario {

    public Gerente(double salario) {
        super(salario);
    }

    public double calcularBonus() {
        return salario * 0.20;
    }
}