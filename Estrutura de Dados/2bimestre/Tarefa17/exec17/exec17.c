#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 17: ultimo

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

//destruição da lista
void destroi(Lista *L) {
	while (*L) {
		Lista n = *L;
		*L = n->prox;
		free(n);
	}
}

//mostra ultimo numero
int last(Lista L) {
	if (!L->prox) return L->item;
	return last(L->prox);
}

int main (void) {
	Lista A = no(3, no(1, no(5, NULL)));
	printf("Lista: ");
	exibe(A);
	printf("\nUltimo numero: %d\n", last(A));
	destroi(&A);
	return 0;
}
