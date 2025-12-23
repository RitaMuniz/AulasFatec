#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 1

typedef int Item;

typedef struct no {
	Item item;
	struct no *prox;
} *Lista;

Lista no(Item x, Lista p) {
      Lista n = (Lista)malloc(sizeof(struct no));
      n->item = x;
      n->prox = p;
      return n;
}

void exibe(Lista L) {
	printf("[");
	
	while (L != NULL) {
		(L->prox != NULL) ? printf("%d, ", L->item) :  printf("%d", L->item);
		L = L->prox;
	}
	
	printf("]");
}

//ordena em ordem crescente e permite itens repetidos
void ins(Item x, Lista *L) {
     while(*L != NULL && (*L)->item<x) {
        L = &(*L)->prox;
     }
     *L = no(x, *L);
}

int main(void) {
    Lista I =  NULL;
    ins(4, &I);
    ins(1, &I);
    ins(3, &I);
    ins(5, &I);
    ins(2, &I);
    
    printf("Lista Ordenada: ");
    exibe(I);
    scanf("%d");
    return 0; 
}
