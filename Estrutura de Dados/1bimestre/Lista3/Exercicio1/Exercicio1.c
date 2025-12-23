#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include "pilha.h"

//Rita de Cassia Muniz de Lima
//Exercicio 1: Teste do programa "Programa de conversão"

char *posfixa(char *e) {
	static char s[256];
	int j=0;
	
	Pilha P = pilha(256);
	
	int i;
	for (i=0; e[i]; i++) {
		if(isdigit(e[i])) {
			s[j++] = e[i];
		}
		else if(strchr("+*-/", e[i])) {
			empilha(e[i], P);
		}
		else if(e[i] == ')') {
			s[j++] = desempilha(P);
		}
	}
		s[j] = '\0';
		destroip(&P);
		return s;
}

int main (void) {
	
	char e[513];
	
	printf("Infixa: ");
	gets(e);
	
	printf("Posfixa: %s\n", posfixa(e));
	
	return 0;
}
