#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 6: criação de lista contendo um intervalo

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

//intervalo da lkista
Lista intervalo(int n) {
	Lista L = NULL;
	
	while (n >= 1) {
		L = no(n, L);
		n--;
	}
	
	return L;
}

int main (void) {
	
	srand(time(NULL));
	Lista A = intervalo(10);
	
	printf("Lista encadeada com intervalo: \n");
	exibe(A);
	
	return 0;
}
