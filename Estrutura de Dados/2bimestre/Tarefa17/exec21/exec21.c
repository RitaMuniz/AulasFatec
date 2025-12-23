#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 21: ordenada

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

//gera lista aleatoria
Lista rnd(int n, int m) {
	if (n==1) {
		return no(rand()%m, NULL);
	}
	return no(rand()%m, rnd(n-1, m));
}

//Retorna o numero minimo
int sorted(Lista L) {
	if (!L->prox) {
		return 1;
	}
	if (L->item > L->prox->item) {
		return 0;
	}
	return sorted(L->prox);
}

int main(void) {
	Lista A = rnd(10, 100);
	printf("Lista: ");
	exibe(A);
	if(sorted(A)) {
		printf("\nLista esta ordenada");
	}
	else{
		printf("\nLista nao esta ordenada");
	}
	destroi(&A);
	return 0;
}
