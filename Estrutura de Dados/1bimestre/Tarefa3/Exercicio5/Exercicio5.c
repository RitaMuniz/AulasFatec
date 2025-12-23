#include<stdio.h>
#include "pilha.h"

//Rita de Cassia Muniz de Lima
//Exercicio 5: Pilha de strings


int main(void) {
	Pilha P = pilha(5);
	char s[11]; //a quantidade é superior ao que a pilha aguenta
	
	int i;
	for(i=0; i<=3; i++) {
		printf("?");
		gets(s);
		empilha(s, P); //empilha só a ultima palavra, pois só irá armazenar a ultima palavra digitada
		//Para que funcionasse direito, necessitaria de mais pilhas ou armazenar em uma pilha de outra forma
	}
	while(!vaziap(P)) puts (desempilha(P));
	
	return 0;
}
