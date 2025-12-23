/*
* ex13: Faça uma classe Funcionario com salário e método para calcular bônus (10%).
* */
public class Funcionario {
    double salario;

    public Funcionario(double salario) {
        this.salario = salario;
    }

    public double calcularBonus(double bonus) {
        return salario * 0.10;
    }
}