#include <stdio.h>
#include <stdlib.h>

	/*	
	Atividade
	Rita de Cássia Muniz de Lima
	
	Fazer código onde usuário dá o nome do arquivo 
	e código mostra quantas linhas o mesmo possui
	*/

int main(int argc, char *argv[]) {
	
	FILE *arq;																			//ponteiro p/ apontar p/ arquivo
	char narq[20], i;																	//var p/ ler arquivo digitado pelo usuario
	int c=1;																			//var para contar as linhas
	
	printf("Contador de linhas");														//Título
	printf("\nO programa ira ler o arquivo indicado e dira quantas linhas possui");		//Explicação ao usuario sobre o programa
	
	printf("\n----------------------------------------------------------------\n");		//Separador
	printf("Digite o nome do arquivo, com .txt no final: ");							//Pede o nome do arquivo
	scanf("%s", &narq);																	//Lê o nome do arquivo
	
	arq = fopen(narq, "r");																//Indica p/ var do ponteiro abrir o arquivo p/ apenas leitura 
	
	if(arq == NULL)																		//Condição caso arquivo esteja vazio
	{
		perror("Erro: ");																//Mensagem de erro
		exit(1);
	}
	
	while(fread(&i, sizeof(char), 1, arq))												//Condição para contar as linhas
	{
		if(i == '\n')																	//Condição para contagem
		{	
			c++;											
		}
	}
	printf("\nO arquivo possui %d linhas\n", c);										//Valor de retorno
	fclose(arq);
	
	return 0;
}
