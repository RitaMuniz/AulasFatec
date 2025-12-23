#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 5: soma dos itens da lista

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

//mostra tamanho da lista
int tamanho(Lista L){
	int tam = 0;
	while (L) {
		tam++;
		L = L->prox;
	}
	
	return tam;
}

//Soma os itens da lista
int soma(Lista L) {
	int sum = 0;
	while (L) {
		sum += L->item;
		L = L->prox;
	}
	
	return sum;
}

int main (void) {
	Lista I = no(3, no(1, no(5, NULL)));
	
	printf("Lista encadeada: ");
	exibe(I);
	printf("\nTamanho = %d\n", tamanho(I));
	printf("Soma dos itens = %d\n", soma(I));
	
	return 0;
}
