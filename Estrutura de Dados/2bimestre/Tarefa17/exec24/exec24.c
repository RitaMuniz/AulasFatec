#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 24: substituicao

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

//Substitui da lista L todos os elementos com valor X pelo valor Y
void replace(int x, int y, Lista* L) {
	Lista lista = *L;
	if (lista->item == x) {
		lista->item = y;
	}
	if (!lista->prox) return;
	replace (x, y, &lista->prox);
}

int main(void) {
	srand(time(NULL));
	Lista A = no(5, no(10, no(9, no(3, no(5, no(5, NULL))))));
	printf("Lista A: ");
	exibe(A);
	printf("\nSubstituindo 5 por 2 em A: ");
	replace(5, 2, &A);
	exibe(A);
	return 0;
}
