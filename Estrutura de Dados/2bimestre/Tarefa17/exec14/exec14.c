#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 14: soma

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

//soma dos itens
int sum(Lista L) {
	if (!L->prox) {
		return L->item;
	}
	return L->item+sum(L->prox);
}

int main (void) {
	
	Lista L = no(3, no(1, no(5, NULL)));
	printf("Lista L: ");
	exibe(L);
	
	printf("\nSoma de todos os itens da lista= %d\n", sum(L));
	return 0;
}
