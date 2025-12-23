#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 22: igualdade

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

//vé se as listas são iguais
int equal(Lista A, Lista B) {
	if (!A->prox && !B->prox) {
		if (A->item == B->item) return 1;
	}
	
	if ((A->prox && !B->prox) || (!A->prox && B->prox)) return 0;
	
	if (A->item != B->item) return 0;
	
	return equal(A->prox, B->prox);
}

int main(void) {
	Lista A = rnd(10, 100);
	Lista B = rnd(10, 100);
	printf("Lista A: ");
	exibe(A);
	printf("\nLista B: ");
	exibe(B);
	if(equal(A, B)) {
		printf("\nListas sao iguais");
	}
	else{
		printf("\nLista nao sao iguais");
	}
	destroi(&A);
	return 0;
}
