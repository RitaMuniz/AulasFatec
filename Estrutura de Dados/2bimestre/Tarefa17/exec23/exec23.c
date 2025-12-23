#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 23: contagem

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
	printf("[");
	
	while (L != NULL) {
		(L->prox != NULL) ? printf("%d, ", L->item) :  printf("%d", L->item);
		L = L->prox;
	}
	
	printf("]");
}

//destruição da lista
void destroi(Lista *L) {
	while (*L) {
		Lista n = *L;
		*L = n->prox;
		free(n);
	}
}

//conta a repetição
int count(int x, Lista L) {
	if (!L->prox && x == L->item) return 1;
	
	if (x == L->item) return 1+count(x, L->prox);
	
	return count(x, L->prox);	
}

int main(void) {
	srand(time(NULL));
	Lista A = no(5, no(10, no(9, no(3, no(5, no(5, NULL))))));
	printf("Lista A: ");
	exibe(A);
	printf("\n\nQtd de vezes que 5 aparece em A: %d\n", count(5, A));
	return 0;
}
