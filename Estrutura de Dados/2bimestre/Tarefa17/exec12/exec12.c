#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 12: intervalo

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

//criando uma lista de intervalo p<u
Lista intervalopu(int m, int n) {
	Lista L = NULL;
	if (m > n) return L;
	while (m <= n) {
		L = no(n, L);
		n--;
	}
	return L;
}

int main (void) {
	
	Lista L = intervalopu(12, 10);
	printf("Lista L: ");
	exibe(L);
	return 0;
}
