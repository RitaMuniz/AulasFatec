/*
* ex11: Crie uma classe ContaBancaria com atributos numero, saldo e métodos sacar() e depositar().
*/
public class ContaBancaria {

    private String numero;
    private double saldo;

    public ContaBancaria(String numero) {
        this.numero = numero;
        this.saldo =  0.0;
    }

    public void sacar(double valor) {
        if (valor <= saldo) {
            saldo -=valor;
        } else {
            System.out.println("Saldo insuficiente");
        }
    }

    public void depositar(double valor) {
        saldo += valor;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public double getSaldo() {
        return saldo;
    }

    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }
}
