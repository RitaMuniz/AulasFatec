#include <stdio.h>
#include <stdlib.h>

struct notasAluno
{
	char nome[50];
	char disciplina[30];
	float nota1;
	float nota2;
};

int main(void) 
{
	int i;
	struct notasAluno aluno[2]; 
	
	printf("\nNotas alunos\n");
	
	for(i=0; i<2; i++)
	{
		
		printf("Digite o nome do aluno: ");
        fgets(aluno[i].nome, 50, stdin);
        getchar();
        
        printf("Digite o nome da disciplina: ");
        fgets(aluno[i].disciplina, 30, stdin);
        getchar();  
		
		printf("Digite nota1: ");
        scanf("%f", &aluno[i].nota1);
        getchar();  
        
        printf("Digite nota2: ");
        scanf("%f", &aluno[i].nota2);
        getchar();  
    }
    
    for(i=0; i<2; i++)
    {
        printf("\nAluno %d\n", i+1);
        printf("Nome do aluno: %s", aluno[i].nome);
        printf("Disciplina: %s", aluno[i].disciplina);
        printf("Nota1: %.2f\n", aluno[i].nota1);
        printf("Nota2: %.2f\n", aluno[i].nota2);
    }
    
    return 0;
}
