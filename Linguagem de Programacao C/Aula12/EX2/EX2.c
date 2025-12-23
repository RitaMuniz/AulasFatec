#include <stdio.h>
#include <stdlib.h>

/**/

int main(int argc, char *argv[]) {
	
	int a,b;													//criaçao de duas veriaveis inteiras
	int *p1, *p2; 										   		//Criação de dois ponteiros inteiros
	
	printf("Digite um valor inteiro: ");						//Impressão de mensagem requisitando valor
	scanf("%d", &a); 											//Leitura do valor
	
	printf("\nDigite outro valor inteiro: ");					//impressão de mensagem requisitando outro valor
	scanf("%d", &b);											//leitura do outro valor
	
	p1= &a;														//apontando p1 para a
	p2= &b;														//apontando p2 para b
	
	printf("\nEndereco de a: %d ", &p1);						//impressão de endereço
	printf("\nEndereco de b: %d", &p2);							//impressão de endereco
	
	if(&p1>&p2) puts("\nEndereco de a e maior que o de b");		//comando SE para caso endereco de a seja maior
	else puts("\nEndereco de b e maior que de a");				//comando SENÃO caso endereco a não seja maior que b 
	
	return 0;													//retorna 0
}
