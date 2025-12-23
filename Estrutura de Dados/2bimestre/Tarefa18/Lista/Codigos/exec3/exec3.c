#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 3

typedef int Item;

typedef struct no {
	Item item;
	struct no *prox;
} *Lista;

Lista no(Item x, Lista p) {
      Lista n = (Lista) malloc(sizeof(struct no));
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

//ordena em ordem crescente de forma recursiva
void ins(Item x, Lista *L) {
     while(*L != NULL && (*L)->item<x) {
              L = &(*L)->prox;
     }
     *L = no(x, *L);
}

void ins_rec(Item x, Lista *L) {
    if(*L != NULL && (*L)->item>=x) {
        *L = no(x, *L);
    }
    if(*L == NULL) {
        *L = no(x, *L);
    }
    if(*L != NULL && (*L)->item<x) {
        ins_rec(x, &(*L)->prox);
    }
}

int main(void) {
    Lista I = NULL;
    int x;
    int i;


    do{
        printf("Digita um numero: ");
        scanf("%d/n", &x);
        ins_rec(x, &I);
    }while(x!=-1);
    
    exibe(I);
    scanf("%d");
    return 0;
}
