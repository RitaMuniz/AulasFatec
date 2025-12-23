/*
* ex12: Crie uma subclasse ContaPoupanca com um método renderJuros()
*/
public class ContaPoupanca extends ContaBancaria {

    public ContaPoupanca(String numero) {
        super(numero);
    }

    public void renderJuros() {
        depositar(getSaldo() * 0.05);
    }
}