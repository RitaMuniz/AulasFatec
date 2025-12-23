#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 1: Programa para criação e exibição

typedef int Item;

//Criação do no
typedef struct no {
	Item item;
	struct no *prox;
} *Lista;

Lista no(int x, Lista p) {
	Lista n = malloc(sizeof(struct no));
	n->item = x;
	n->prox = p;
	
	return n;
}

//Exibição do no
void exibe(Lista L) {
	while (L != NULL) {
		(L->prox != NULL) ? printf("%d, ", L->item) :  printf("%d", L->item);
		L = L->prox;
	}
}

int main (void) {
	Lista I = no(3, no(1, no(5, NULL)));
	
	printf("Lista encadeada: ");
	exibe(I);
	return 0;
}
