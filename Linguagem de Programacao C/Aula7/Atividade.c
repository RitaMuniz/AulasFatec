#include <stdio.h>#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*Sistema escolar*/

struct dadosUniversidade 
{
    char nUniv[50];         // nome da universidade
    int numdisc;            // numero de disciplinas
    char curso[50];         // nome do curso
};

struct dadosDisciplina 
{
    int numdisc;            // numero de disciplinas
    char ndisc[30];         // nome da disciplina
    int ch;                 // carga horaria
    float n1;               // nota 1
    float n2;               // nota 2
    float n3;               // nota 3
    int freq;               // frequencia
};

int main(int argc, char *argv[]) 
{
    // Variaveis
    struct dadosUniversidade universidade[100];
    struct dadosDisciplina disciplina[100];
    int n = 0;
    int i = 0, 
	j = 0;
    int m = 0;
    float media[100];

    printf("Sistema de cadastro de dados de alunos de ensino superior\n");

    printf("\nEscreva o nome da instituicao de ensino: ");
    fgets(universidade[0].nUniv, 50, stdin);
    strtok(universidade[0].nUniv, "\n"); 

    printf("Escreva a quantidade de alunos que serao cadastrados nesse sistema: ");
    scanf("%d", &m);
    getchar(); 

    for (i = 1; i <= m; i++) 
	{
        printf("\n\n----Insercao de dados----\n\n");

        // Inserção de dados do aluno
        printf("\nAluno %d", i);

        printf("\nEscreva o nome do curso: ");
        fgets(universidade[i].curso, 50, stdin);
        strtok(universidade[i].curso, "\n");

        printf("\nEscreva o numero de disciplinas matriculadas: ");
        scanf("%d", &disciplina[i].numdisc);
        getchar();

        n = disciplina[i].numdisc;

        // Sistema de repetição de acordo com o numero de disciplinas
        for (j = 1; j <= n; j++) 
		{
            printf("\n\n----Disciplina %d----\n\n", j);
            printf("\nEscreva o nome da disciplina: ");
            fgets(disciplina[j].ndisc, 30, stdin);
            strtok(disciplina[j].ndisc, "\n"); 

            printf("\nEscreva o numero da carga horaria da disciplina: ");
            scanf("%d", &disciplina[j].ch);
            getchar();

            printf("\nEscreva o nota 1: ");
            scanf("%f", &disciplina[j].n1);
            getchar();

            printf("\nEscreva o nota 2: ");
            scanf("%f", &disciplina[j].n2);
            getchar();

            printf("\nEscreva o nota 3: ");
            scanf("%f", &disciplina[j].n3);
            getchar();

            printf("\nEscreva a porcentagem da sua frequencia: ");
            scanf("%d", &disciplina[j].freq);
            getchar();
    	}
	}
    
		printf("\n----Dados Registrados----\n");
    	printf("Nome da universidade: %s\n", universidade[0].nUniv);

    for (i = 1; i <= m; i++) 
	{
        printf("\n--Aluno %d --\n", i);
        printf("Curso: %s\n", universidade[i].curso);
        printf("Quantidade de disciplinas cursadas: %d\n", disciplina[i].numdisc);

        for (j = 1; j <= n; j++) {
            printf("\nDisciplina %d\n", j);
            printf("Nome da disciplina: %s\n", disciplina[j].ndisc);
            printf("Carga Horaria: %d\n", disciplina[j].ch);
            printf("Nota 1: %.2f\n", disciplina[j].n1);
            printf("Nota 2: %.2f\n", disciplina[j].n2);
            printf("Nota 3: %.2f\n", disciplina[j].n3);

            // Condição para ser aprovado ou não
            if (media[j] >= 6 && disciplina[j].freq >= 75) {
                printf("\nSituacao: Aprovado!");
            } else {
                printf("\nSituacao: Reprovado!");
            }
        }
        printf("\n-----------------------------------\n");
    }

    return 0;
}
