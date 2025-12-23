#include <stdio.h>
#include <stdlib.h>

//Rita de Cássia Muniz de Lima
//Exercício 1: Valores trocados

int main(int argc, char *argv[]) {
	
	int n1, n2, temp;
	
	printf("Digite dois numeros inteiros: ");
	scanf("%d %d", &n1, &n2);
	
	temp = n1;
	n1 = n2;
	n2 = temp;
	
	printf("/n Valores trocados: %d %d", n1, n2);
	
	return 0;
}
