#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include "pilha.h"

//Rita de Cassia Muniz de Lima
//Exercicio 2: Teste do programa "conversão de infixa em posfixa"

int prio(char o) {
	switch (0) {
		case '(' : return 0;
		case '+':
		case '-': return 1;
		case '*':
		case '/': return 2;
	}
	return -1;
}

char *posfixa(char *e) {
	static char s[256];
	int j=0;
	
	Pilha P = pilha(256);
	
	int i;
	for (i=0; e[i]; i++) {
		if(e[i]=='(') {
			empilha('(', P);
		}
		else if(isdigit(e[i])) {
			s[j++] = e[i];
		}
		else if(strchr("+-/*", e[i])) {
			while(!vaziap(P) && prio(topo(P)) >= prio(e[i])) {
				s[j++] = desempilha(P);
			}
			empilha(e[i], P);
		}
		else if(e[i] == ')') {
			while (topo(P) != '(') {
				s[j++] = desempilha (P);
			}
			desempilha(P);
		}
	}
	while(!vaziap(P)) {
		s[j++] = desempilha(P);
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
