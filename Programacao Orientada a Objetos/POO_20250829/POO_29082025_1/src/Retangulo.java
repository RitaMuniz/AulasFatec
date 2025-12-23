/*
* ex18: Faça uma classe Retangulo com largura, altura e método calcularArea().
*/
public class Retangulo {

    double largura;
    double altura;

    public Retangulo(double largura, double altura) {
        this.largura = largura;
        this.altura = altura;
    }

    public double calculaArea() {
        return  (largura*altura)/2;
    }
}