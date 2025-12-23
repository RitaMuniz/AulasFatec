public class Retangulo extends FormasGeometricas{

    private double base;
    private double altura;
    private double comprimento;

    public Retangulo(double base, double altura, double comprimento) {
        this.base = base;
        this.altura = altura;
        this.comprimento = comprimento;
    }

    @Override
    public double calcularArea() {
        return base * altura;
    }

    @Override
    public double calcularPerimetro() {
        return 2 * (base + altura);
    }

    @Override
    public double calcularVolume() {
        return base * altura * comprimento;
    }
}