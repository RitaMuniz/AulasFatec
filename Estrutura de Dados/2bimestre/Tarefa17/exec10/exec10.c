#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 10: pertinencia

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

//destruição da lista
void destroi(Lista *L) {
	while (*L) {
		Lista n = *L;
		*L = n->prox;
		free(n);
	}
}

//se um numero pertence a lista
int pertence(int x, Lista L){
	while (L) {
		if (x == L->item)  {
			puts("\npertence!"); 
			return 1;
		}
		
		L = L->prox;
	}
	puts("\nnao pertence!");
	return 0;
}

int main (void) {
	
	srand(time(NULL));
	Lista L = aleatoria(10,100);
	int x;
	
	printf("Lista L = \n");
	exibe(L);
	
	do {
		printf("\n\nDigite o numero maior que 0 que voce quer pesquisar (ou -1 pra sair): ");
		scanf("%d", &x);
		pertence(x, L);
	} while(x >= 0);

	destroi(&L);

	return 0;
}
