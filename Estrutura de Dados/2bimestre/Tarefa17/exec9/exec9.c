#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 9: item maximo

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

//maior item da lista
int maximo(Lista L) {
	if (!L) puts("Erro fatal: lista vazia!"); abort;
	int max = L->item;
	while (L) {
		if(L->item > max) max = L->item;
		L = L->prox;
	}
	return max;
}

int main (void) {
	
	Lista L = no(3, no(1, no(5, NULL)));
	printf("Lista L =");
	exibe(L);
	printf("\nMaior item da lista = %d\n", maximo(L));
	destroi(&L);

	return 0;
}
