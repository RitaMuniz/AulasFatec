public class Hexagono extends FormasGeometricas{

    private double lados;
    private double apotema;
    private double altura;

    public Hexagono(double lados, double apotema, double altura) {
        this.lados = lados;
        this.apotema = apotema;
        this.altura = altura;
    }

    @Override
    public double calcularArea() {
        return 3 * lados * apotema;
    }

    @Override
    public double calcularPerimetro() {
        return 6 * lados;
    }

    @Override
    public double calcularVolume() {
        return (3 * lados * apotema) * altura;
    }
}