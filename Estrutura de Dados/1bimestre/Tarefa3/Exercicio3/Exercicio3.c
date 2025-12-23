#include<stdio.h>
#include "pilha.h"

//Rita de Cassia Muniz de Lima
//Exercicio 3: Inversão de palavras

int main(void) {
	
	//Variaveis
	char f[256];
	Pilha A = pilha(256);
	int i;
	
	printf("Inverte frase\n");
	printf("Digite a frase: ");
	gets(f);
	
	//Armazena os caracteres na pilha
	for(i=0; f[i]; i++) {
		empilha(f[i], A);
	}
	
	printf("\nInverso: ");
	
	//Imprime o que tiver na pilha
	while(!vaziap(A)) {
		printf("%c", desempilha(A));
	}
	
	destroip(&A);
	
	return 0;
}
