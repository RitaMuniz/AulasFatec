#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 8: ultimo item

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

//ultimo item da lista
int ultimo(Lista L) {
	if (!L) puts("Erro fatal: lista vazia!"); abort;
	int ult;
	while (L) {
		ult = L->item;
		L = L->prox;
	}
	return ult;
}

int main (void) {
	
	Lista L = no(3, no(1, no(5, NULL)));
	printf("Lista L =");
	exibe(L);
	printf("\nUltimo item da lista = %d\n", ultimo(L));
	destroi(&L);

	return 0;
}
