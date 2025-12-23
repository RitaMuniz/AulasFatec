public class Pentagono extends FormasGeometricas{

    private double altura;
    private double lados;
    private double apotema;

    public Pentagono(double lados, double altura, double apotema) {

        this.lados = lados;
        this.altura = altura;
        this.apotema = apotema;
    }

    @Override
    public double calcularArea() {
        return (5*lados*apotema)/2;
    }

    @Override
    public double calcularPerimetro() {
        return 5* lados;
    }

    @Override
    public double calcularVolume() {
        return ((5*lados*apotema)/2)*altura;
    }
}