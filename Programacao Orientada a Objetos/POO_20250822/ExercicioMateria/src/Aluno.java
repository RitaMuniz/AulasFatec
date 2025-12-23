import java.util.ArrayList;

public class Aluno {

    private int matricula;
    private String nome;
    private String email;
    private String status;
    private String dataNas;
    private ArrayList<Materia> materias;

    public Aluno (int matricula, String nome, String email, String status, String dataNas) {
        this.matricula = matricula;
        this.nome = nome;
        this.email = email;
        this.status = status;
        this.dataNas = dataNas;
        this.materias = new ArrayList<>();
    }

    public void trancarMatricula(Materia materia) {
        if(materias.contains(materia)) {
            materias.remove(materia);
        }
        else {
            System.out.println("Essa matéria não esta matriculada");
        }
    }

    public void matricular(Materia materia) {
        materias.add(materia);
    }

    public void exibirMaterias() {
        System.out.println(materias.get(0).getTitulo());
        System.out.println(materias.get(1).getTitulo());
    }

    public int getMatricula() {
        return matricula;
    }

    public void setMatricula(int matricula) {
        this.matricula = matricula;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDataNas() {
        return dataNas;
    }

    public void setDataNas(String dataNas) {
        this.dataNas = dataNas;
    }
}
