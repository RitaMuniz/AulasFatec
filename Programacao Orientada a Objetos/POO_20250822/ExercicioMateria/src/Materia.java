public class Materia {

    private int cargaHoraria;
    private String titulo;
    private int codigo;
    private String professor;
    private String horario;
    private boolean optativa;

    public Materia(int cargaHoraria, String titulo, int codigo, String professor, String horario, boolean optativa) {
        this.cargaHoraria = cargaHoraria;
        this.titulo = titulo;
        this.codigo = codigo;
        this.professor = professor;
        this.horario = horario;
        this.optativa = optativa;
    }

    public void agendarProva() {
        System.out.println("Agendar prova");
    }

    public void matricular() {
        System.out.println("Matricular");
    }

    public int getCargaHoraria() {
        return cargaHoraria;
    }

    public void setCargaHoraria(int cargaHoraria) {
        this.cargaHoraria = cargaHoraria;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getProfessor() {
        return professor;
    }

    public void setProfessor(String professor) {
        this.professor = professor;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public boolean isOptativa() {
        return optativa;
    }

    public void setOptativa(boolean optativa) {
        this.optativa = optativa;
    }
}
