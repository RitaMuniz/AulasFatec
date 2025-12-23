#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 16: aleatoria

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

int main (void) {
	int n;
	int m;
	printf("Quantos itens deve ter a lista: ");
	scanf("%d", &n);
	printf("Os numeros devem ser entre 0 e :");
	scanf("%d", &m);
	printf("Lista encadeada aleatoria: \n");
	Lista A = rnd(n,m-1);
	exibe(A);
	destroi(&A);
	return 0;
}
