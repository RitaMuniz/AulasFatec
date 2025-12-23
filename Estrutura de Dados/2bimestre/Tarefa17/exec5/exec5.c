#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 5: Programa para lista aleatória

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

//Cria uma lista aleatoria
int aleatoria(int m, int n) {
	Lista L = NULL;
	while (n>0) {
		L = no(rand()%m, L);
		n--;
	}
	return L;
}

int main (void) {
	
	srand(time(NULL));
	Lista A = aleatoria(10,100);
	
	printf("Lista encadeada aleatoria: \n");
	exibe(A);
	
	return 0;
}
