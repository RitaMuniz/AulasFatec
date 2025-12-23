#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 7: Programa para anexação

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
	printf("[ ");
	while (L != NULL) {
		(L->prox != NULL) ? printf("%d, ", L->item) :  printf("%d", L->item);
		L = L->prox;
	}
	printf(" ]");
}

//Anexando as listas
void anexa(Lista *A, Lista B) {
	if (!B) return;
	while (*A) {
		A = &(*A)->prox;
	}
	*A = B;
}

int main (void) {
	
	Lista H = no(4, no(2, NULL));
	Lista I = no(3, no(1, no(5, NULL)));
	printf("Lista H =");
	exibe(H);
	printf("\nLista I = "); 
	exibe(I);
	printf("\n\nClique no enter para anexar i em h\n");
	getchar();
	anexa(&H, I);
	printf("Lista H =");
	exibe(H);
	printf("\nLista I = "); 
	exibe(I);
	
	return 0;
}
