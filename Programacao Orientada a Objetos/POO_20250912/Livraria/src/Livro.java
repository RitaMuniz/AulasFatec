import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Livro {

    private List<Estoque> livros;

    public Livro() {
        livros = new ArrayList<>();
        livros.add(new Estoque(Categoria.ADMINISTRACAO, "A SOLUÇÃO PARA A SUA EMPRESA: EXPORTAÇÃO", "Steven Dabbah", "1",
                "1234567", " 17 x 24 cm",
                """
                Exportar não é tarefa das mais simples. Requer pessoal especializado que, além de possuir conhecimento 
                de negociação internacional e aspectos culturais, precisa conhecer processos administrativos, logística,
                entraves burocráticos, legislações específicas, etc.
                O objetivo deste livro é desvendar esses conhecimentos, abordando todos os aspectos relevantes da 
                exportação, desde a internacionalização da empresa até a etapa final de um processo de exportação, 
                de forma clara e didática. 
                Destinado a estudantes de comércio exterior, empresários, executivos, consultores e profissionais de 
                exportação.""",
                184, 30.00, 11));

        livros.add(new Estoque(Categoria.COMPUTACAO_GRAFICA, "AUTOCAD 13 FOR WINDOWS - GUIA PRÁTICO", "Marcelo Chaves Ladeira e Claudia Campos Lima",
                "4", "9876654", " 16 x 23 cm",
                """
                É dirigido aos usuários de AutoCAD com ou sem experiência no software. 
                Abrange todos os comandos básicos de desenho em 2D e 3D, além da criação de bibliotecas e arquivos 
                de referência. 
                Cada capítulo contém um assunto com explicações detalhadas de cada comando, figuras explicativas e telas 
                do programa.""",
                504, 57.00, 24));

        livros.add(new Estoque(Categoria.ELETRONICA,"ANÁLISE DE CIRCUITOS EM CORRENTE ALTERNADA", "Rômulo Oliveira Albuquerque",
                "3", "3456765", " 15 x 23 cm",
                """
                A obra aborda grandezas senoidais, eletromagnetismo, análise fasorial em C.A. em circuitos RLC, números
                complexos, circuitos trifásicos, instrumentos de medida, filtros decibel, diferenciadores, integradores,
                etc.""",
                144, 28.00, 55));

        livros.add(new Estoque(Categoria.INTERNET, "FAÇA UM SITE - E-Commerce", "Carlos Antonio José Oliviero", "2",
                "9876556", " 17 x 24 cm", "Sem sinopse", 356, 49.00, 3));

        livros.add(new Estoque(Categoria.SISTEMAS_OPERACIONAIS, "LINUX PARA REDES BRASILEIRAS", "Heverton Anunciação", "1",
                "8484876", "16 x 23 cm",
                """
                        Esta obra é destinada aos já usuários de informática, principalmente na área de sistemas 
                        operacionais. Apresenta, de forma simples e didática: conceitos, idéias, metodologia, infra-
                        estrutura, operação e o princípio da instalação de uma Intranet ou de um serviço de acesso 
                        Internet, utilizando-se do Linux, que conquistou o mundo em apenas sete anos de existência. Além
                        disso, possui anexos contendo: sites interessantes na Internet, principais comandos Linux/Unix, 
                        programação shell script e dispositivos lógicos.""",
                200, 32.00, 8));

        livros.add(new Estoque( Categoria.TELECOMUNICACOES, "TELEFONIA DIGITAL", "Marcelo Sampaio de Alencar", "1",
                "8484876", "16 x 23 cm",
                """
                        O livro apresenta as noções básicas de telefonia com enfoque para os sistemas digitais, incluindo
                        aspectos de digitalização e multiplexação de sinais, centrais e redes telefônicas. Aborda também
                        o planejamento do sistema telefônico, redes de computadores, redes de alta velocidade, telefonia
                        móvel celular e comunicações pessoais, teoria de tráfego telefônico e gerência integrada de redes
                        e serviços. O livro apresenta ainda um histórico da evolução da telefonia no Brasil.""",
                344, 54.00, 8));
    }

    public void mostrarLivros(int escolha, Carrinho c) {
        Categoria filtro = null;
        switch (escolha) {
            case 1 -> filtro = Categoria.ADMINISTRACAO;
            case 2 -> filtro = Categoria.COMPUTACAO_GRAFICA;
            case 3 -> filtro = Categoria.ELETRONICA;
            case 4 -> filtro = Categoria.INTERNET;
            case 5 -> filtro = Categoria.SISTEMAS_OPERACIONAIS;
            case 6 -> filtro = Categoria.TELECOMUNICACOES;
            default -> {
                System.out.println("Erro: categoria inválida");
                return;
            }
        }

        for (Estoque estoque : livros) {
            if (estoque.getCategoria() == filtro) {
                dadosLivro(estoque, c);
            }
        }
    }

    public void dadosLivro(Estoque estoque, Carrinho c) {
        System.out.printf("""
                                    ------------------------------------------------------------------------------------
                                    Titulo: %s
                                    Autor: %s
                                    Edicao: %s
                                    ISBN: %s
                                    Tamanho: %s
                                    N. de Pag.: %d
                                    Sinopse: %s
                                    Preco: R$ %.2f
                                    Qtde em Estoque: %d
                                    ------------------------------------------------------------------------------------
                                    """,
                estoque.getTitulo(), estoque.getAutor(), estoque.getEdicao(),
                estoque.getIsbn(), estoque.getTamanho(), estoque.getNumPag(),
                estoque.getSinopse(), estoque.getPreco(), estoque.getQtde());

        desejaComprar(estoque, c);
    }

    public void desejaComprar(Estoque estoque, Carrinho c) {
        Scanner s = new Scanner(System.in);
        System.out.println("Deseja comprar esse item? 1:SIM; 2:NAO ");
        int escolha = s.nextInt();
        if(escolha == 1) {
            System.out.println("Quantidade: ");
            int qtde = s.nextInt();
            c.adicionar(estoque, qtde);
        }
    }
}