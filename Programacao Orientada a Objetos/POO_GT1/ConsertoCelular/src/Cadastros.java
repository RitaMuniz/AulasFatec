import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Cadastros {

    private static List<Cliente> c = new ArrayList<>();
    private static List<Celular> cl = new ArrayList<>();
    private static List<Materiais> m = new ArrayList<>();
    private static List<OrdemServico> o = new ArrayList<>();

    public static void cadastrarCliente(Scanner s) {
        System.out.print("Nome: ");
        String nome = s.nextLine();
        System.out.print("Cpf: ");
        String cpf = s.nextLine();
        System.out.println("Telefone para contato (com ddd e sem tracos ou espacos): ");
        String tel = s.nextLine();
        System.out.println("Email: ");
        String email = s.nextLine();

        c.add(new Cliente(nome, cpf, tel, email));
        System.out.println("\nCliente cadastrado!");
    }

    public static void cadastrarCelular(Scanner s) {
        Marcas marcas = null;
        if (c.isEmpty()) {
            System.out.println("Cadastre um cliente primeiro!");
            return;
        }
        System.out.println("anEscolha o cliente (índice):");
        for (int i = 0; i < c.size(); i++) {
            System.out.println(i + " - " + c.get(i));
        }
        System.out.println("Indice: ");
        int idx = s.nextInt();
        Cliente dono = c.get(idx);

        System.out.print("""
                Marca:
                1: SAMSUNG
                2: XIAOMI
                3: APPLE
                4: MOTOROLA
                5: NOKIA
                Opção:""");
        int op = s.nextInt();
        switch (op) {

            case 1 -> marcas = Marcas.SAMSUNG;
            case 2 -> marcas = Marcas.XIAOMI;
            case 3 -> marcas = Marcas.APPLE;
            case 4 -> marcas = Marcas.MOTOROLA;
            case 5 -> marcas = Marcas.NOKIA;
        }
        System.out.print("Modelo: ");
        String modelo = s.nextLine(); s.nextLine();

        cl.add(new Celular(marcas, modelo, dono));
        System.out.println("\nCelular cadastrado!");
    }

    public static void cadastrarMaterial(Scanner s) {
        TipoMateriais tipo = null;
        System.out.println("""
                Tipo do material: 
                
                1: DISPLAY
                2: BATERIA
                3: CAMERA
                4: CONECTOR,
                5: BOTAO,
                6: OUTROS""");
        int op = s.nextInt();
        s.nextLine();
        switch (op) {
            case 1 -> tipo = TipoMateriais.DISPLAY;
            case 2 -> tipo = TipoMateriais.BATERIA;
            case 3 -> tipo = TipoMateriais.CAMERA;
            case 4 -> tipo = TipoMateriais.CONECTOR;
            case 5 -> tipo = TipoMateriais.BOTAO;
            case 6 -> tipo = TipoMateriais.OUTROS;
        }

        System.out.print("Nome do Material: ");
        String nome = s.nextLine();
        System.out.print("Quantidade: ");
        int qtd = s.nextInt();

        m.add(new Materiais(tipo, nome, qtd));
        System.out.println("\nPeça cadastrada!");
    }

    public static void abrirOrdem(Scanner s) {
        if (c.isEmpty() || cl.isEmpty()) {
            System.out.println("Cadastre cliente e aparelho primeiro!");
            return;
        }
        System.out.println("Escolha cliente (índice):");
        for (int i = 0; i < c.size(); i++) {
            System.out.println(i + " - " + c.get(i));
        }
        System.out.println("Indice: ");
        int idxC = s.nextInt();
        Cliente cliente = c.get(idxC);

        System.out.println("Escolha aparelho (índice):");
        for (int i = 0; i < cl.size(); i++) {
            System.out.println(i + " - " + cl.get(i));
        }
        System.out.println("Indice: ");
        int idxA = s.nextInt();
        s.nextLine();
        Celular celular = cl.get(idxA);

        System.out.print("Descrição do problema: ");
        String desc = s.nextLine();

        o.add(new OrdemServico(cliente, celular, desc));
        System.out.println("\nOrdem aberta!");
    }

    public static void usarMaterial(Scanner s) {
        if (o.isEmpty() || m.isEmpty()) {
            System.out.println("Cadastre ordem e peça primeiro!");
            return;
        }

        System.out.println("Escolha ordem (índice):");
        for (int i = 0; i < o.size(); i++) {
            System.out.println(i + " - " + o.get(i));
        }
        System.out.println("Indice: ");
        int idxO = s.nextInt();
        s.nextLine();
        OrdemServico os = o.get(idxO);

        System.out.println("Escolha peça (índice):");
        for (int i = 0; i < m.size(); i++) {
            System.out.println(i + " - " + m.get(i));
        }
        System.out.println("Indice: ");
        int idxP = s.nextInt();
        s.nextLine();
        Materiais materiais = m.get(idxP);

        System.out.print("Quantidade usada: ");
        int qtd = s.nextInt();
        s.nextLine();

        if (materiais.usar(qtd)) {
            os.adicionarMaterial(new Materiais(materiais.getTipo(), materiais.getNome(), qtd));
            System.out.println("Peça usada na ordem!");
        } else {
            System.out.println("Estoque insuficiente!");
        }
    }

    public static void concluirOrdem(Scanner s) {
        if (o.isEmpty()) {
            System.out.println("\n------------Nenhuma ordem cadastrada!-------------");
            return;
        }
        System.out.println("Escolha ordem (índice):");
        for (int i = 0; i < o.size(); i++) {
            System.out.println(i + " - " + o.get(i));
        }
        System.out.println("Indice: ");
        int idx = s.nextInt();
        o.get(idx).enviarMensagem();
        o.get(idx).concluir();
        System.out.println("Ordem concluída!");

    }

    public static void listarOrdens() {
        if (o.isEmpty()) {
            System.out.println("Nenhuma ordem registrada!");
            return;
        }
        o.forEach(System.out::println);
    }
}