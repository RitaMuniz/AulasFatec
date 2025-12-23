/*
* ex17: Crie um exemplo de sobrecarga de métodos (overloading).
*/
public class Calculadora {

    public int multiplicar(int a, int b) {
        return a*b;
    }

    //Método com mesmo nome, mas tipo diferente
    public double multiplicar(double a, double b) {
        return a*b;
    }
}