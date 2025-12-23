#include <stdio.h>
#include <stdlib.h>

/*Exemplo de Variaveis locais e globais*/

float m, n1, n2;												//var global

void entrada(void);												//função

int main(int argc, char *argv[]) {
	
	char resp;													//var local
	
	do 
	{
		entrada();												//chamada da função
		
		m=(n1+n2)/2;
		
		printf("\nMedia do aluno: %.2f\n", m);
		
		printf("\nDeseja calcular outra media? (s/n): ");		//pergunta que determina o loop
		fflush(stdin);
		scanf("%c", &resp);
	}
	while(resp== 's');											//condição  do loop
	
	return 0;
}

void entrada(void)												//abertura da função
{
	printf("\nDigite a primeira nota: ");
	scanf("%f", &n1);
	
	printf("\nDigite a segunda nota: ");
	scanf("%f", &n2);
	
	return;														//retorna valores
}
