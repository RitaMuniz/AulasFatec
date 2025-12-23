#include<stdio.h>
#include "fila.h"

//Rita de Cassia Muniz de Lima
//Exercicio 2: Saida de Programa

int main (void) {
	Fila F = fila(5);
	
	int i;
	for(i=0; i<=3; i++) {
		enfileira('A'+i, F);
	}
	while(!vaziaf(F)) {
		printf("%c\n", desenfileira(F));
	}
	destroif(&F);
	return 0;
}
