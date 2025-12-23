#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 19: enesimo

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

//Retorna o enésimo item de uma lista encadeada
int nth(int n, Lista L) {
	if (n == 1) return L->item;
	
	if (!L) {
		puts("\nErro fatal: n maior que a lista");
		exit(1);
	}
	
	return nth(n-1, L->prox);
}

int main (void) {
	int x;
	Lista A = rnd(10, 100);
	printf("Lista: ");
	exibe(A);
	do {
		printf("\n\nDigite o enesimo numero que queira saber (ou -1 pra sair): ");
		scanf("%d", &x);
		printf("Item %d da lista= %d\n", x, nth(x, A));
	} while(x >= 0);
	destroi(&A);
	return 0;
}
