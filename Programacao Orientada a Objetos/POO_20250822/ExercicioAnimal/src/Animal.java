public class Animal {

    private String som;
    private String comida;
    private String tipo;

    public Animal(String som, String comida, String tipo) {
        this.som = som;
        this.comida = comida;
        this.tipo = tipo;
    }

    public void correr(){
        System.out.println("Correndo!");
    };

    public void parar() {
        System.out.println("Parado... %s".formatted(som));
    }

    public void comer() {
        System.out.println("Comendo %s".formatted(comida));
    }

    public void dormir() {
        System.out.println("ZZZZzzzzZZZZZzzzzZZZz....");
    }

    public String getSom() {
        return som;
    }

    public void setSom(String som) {
        this.som = som;
    }

    public String getComida() {
        return comida;
    }

    public void setComida(String comida) {
        this.comida = comida;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}
