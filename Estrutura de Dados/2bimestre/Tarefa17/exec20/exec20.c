#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 20: minimo

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
int minimum(Lista L) {
	if (!L->prox) {
		return L->item;
	}
	int min = minimum(L->prox);
	if (L->item < min) {
		return L->item;
	}
	else {
		return min;
	}
}

int main (void) {
	Lista A = rnd(10, 100);
	printf("Lista: ");
	exibe(A);
	printf("\nO menor numero da lista= %d\n", minimum(A));
	destroi(&A);
	return 0;
}
