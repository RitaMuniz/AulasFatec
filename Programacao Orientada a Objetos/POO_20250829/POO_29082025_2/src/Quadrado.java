public class Quadrado extends FormasGeometricas{

    private double tamanho;

    public Quadrado(double tamanho) {
        this.tamanho = tamanho;
    }

    @Override
    public double calcularArea() {
        return Math.pow(tamanho, 2);
    }

    @Override
    public double calcularPerimetro() {
        return tamanho * 4;
    }

    @Override
    public double calcularVolume() {
        return (Math.pow(tamanho,3));
    }
}