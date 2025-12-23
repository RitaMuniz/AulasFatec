public class Gato extends Animal {

    public Gato(String som,String comida, String tipo) {
        super(som, comida, tipo);
    }

    public void miar() {;
        System.out.println("O gato está miando: " + getSom());
    }
}
