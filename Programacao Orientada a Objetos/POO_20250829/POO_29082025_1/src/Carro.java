/*
* ex16: Mostre exemplo de composição: Carro possui um Motor.
*/
public class Carro {

    private Motor motor = new Motor();

    public void ligarCarro() {
        motor.ligar();
        System.out.println("Carro ligado");
    }
}