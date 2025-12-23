#include <stdio.h>
#include <stdlib.h>

/*
	Atividade
	Rita de Cássia Muniz de Lima
	
	Ler 2 arquivos de texto. Criar terceiro arquivo com conteúdo de ambos
	*/

int main(int argc, char *argv[]) {
	
FILE *arq1, *arq2, *arq3;																//ponteiros p/ apontar p/ arquivos
	char narq[25];																		//var p/ ler arquivo digitado pelo usuario
	
	printf("Juntando textos");															//Título
	printf("\nO programa ira ler os arquivos e juntar conteúdo em um terceiro");		//Explicação ao usuario sobre o programa
	
	printf("\n--------------------------------------------------------------\n");		//Separador
	printf("Digite o nome do primeiro arquivo, com .txt no final: ");					//Pede o nome do arquivo
	scanf("%s", &narq);																	//Lê o nome do arquivo
	
	arq1 = fopen(narq, "r");															//Indica p/ var do ponteiro abrir o arquivo p/ apenas leitura 
	
	if(arq1 == NULL)																	//Condição caso arquivo seja nulo
	{
		perror("Erro no primeiro arquivo: ");											//Mensagem de erro
		exit(1);
	}
	
	printf("\nDigite o nome do segundo arquivo, com .txt no final: ");
	scanf("%s", &narq);																
	
	arq2 = fopen(narq, "r");															//Indica p/ var do ponteiro abrir o arquivo p/ apenas leitura 
	
	if(arq2 == NULL)																	//Condição caso arquivo seja nulo
	{
		perror("Erro no segundo arquivo: ");											//Mensagem de erro
		exit(1);
	}
	
	arq3 = fopen("JuntaArq.txt", "w");													//Abre arquivo para escrever e aponta para ponteiro
	
	if(arq3 == NULL)
	{
		perror("Erro no terceiro arquivo: ");
		exit(1);
	}
	
	
	fgets(narq, 25, arq1);																//Passa valor do arq1 para narq
	fputs(narq, arq3);																	//Passa valor de narq para arq3
	
	fgets(narq, 25, arq2);																//Passa valor do arq2 para narq
	fputs(narq, arq3);																	//Passa valor de narq para arq3
	
	printf("\nArquivos juntados!\n");													//Retorno
	
	fclose(arq1);																		//Fecha arq1
	fclose(arq2);																		//Fecha arq2
	fclose(arq3);																		//Fecha arq3
	
	return 0;
}
