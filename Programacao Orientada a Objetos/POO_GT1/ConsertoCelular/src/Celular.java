public class Celular {
    private Marcas marca;
    private String modelo;
    private Cliente dono;

    public Celular(Marcas marca, String modelo, Cliente dono) {
        this.marca = marca;
        this.modelo = modelo;
        this.dono = dono;
    }

    public Cliente getDono() {
        return dono;
    }

    @Override
    public String toString() {
        return marca + " " + modelo + " - Dono: " + dono.getNome();
    }
}