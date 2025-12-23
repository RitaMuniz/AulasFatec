public class Main {

    public static void main(String[] args) {

        Materia poo = new Materia(
                800,
                "Orientacao a Objetos",
                1,
                "Wellington",
                "19hs",
                false);

        Materia matematica = new Materia(
                800,
                "Matematica Discreta",
                2,
                "Frare",
                "23hs",
                false);

        Materia contabilidade = new Materia(
                3,
                "Contabilidade",
                3,
                "Daniela",
                "18hs",
                false);

        Materia historia = new Materia(
                200,
                "Historia da Computacao",
                4,
                "Valdir",
                "19hs",
                true);

        Aluno rita = new Aluno(
                10101,
                "Rita",
                "rita.lima@email.com",
                "cursando",
                "18/10/05");
        Aluno phelyppe = new Aluno(
                10102,
                "Phelyppe",
                "phelyppe.catogo@email.com",
                "cursando",
                "29/02/28");

        Aluno eduarde = new Aluno(
                10103,
                "Eduarde",
                "eduarde.yahoo@yahoo.br",
                "trancou",
                "10/10/10");


        //alunos cadastrados em 2 materias
        //imprimir nome, status, a lista das materias


        System.out.println("Aluno 1");
        System.out.printf("\nMatricula: %d \nNome: %s \nEmail: %s \nStatus: %s \nData Nasc.: %s", rita.getMatricula(), rita.getNome(), rita.getEmail(), rita.getStatus(), rita.getDataNas());
        rita.matricular(poo);
        rita.matricular(matematica);
        System.out.println("\nMaterias matriculadas: ");
        rita.exibirMaterias();

        System.out.println("Aluno 2");
        System.out.printf("\nMatricula: %d \nNome: %s \nEmail: %s \nStatus: %s \nData Nasc.: %s", phelyppe.getMatricula(), phelyppe.getNome(), phelyppe.getEmail(), phelyppe.getStatus(), phelyppe.getDataNas());
        phelyppe.matricular(contabilidade);
        phelyppe.matricular(historia);
        System.out.println("\nMaterias matriculadas: ");
        phelyppe.exibirMaterias();

        System.out.println("Aluno 3");
        System.out.printf("\nMatricula: %d \nNome: %s \nEmail: %s \nStatus: %s \nData Nasc.: %s", eduarde.getMatricula(), eduarde.getNome(), eduarde.getEmail(), eduarde.getStatus(), eduarde.getDataNas());
        eduarde.matricular(matematica);
        eduarde.matricular(poo);
        System.out.println("\nMaterias matriculadas: ");
        eduarde.exibirMaterias();
    }
}