#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 2

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

//ordena em ordem crescente e permite itens repetidos
void ins(Item x, Lista *L) {
     while(*L != NULL && (*L)->item<x) {
              L = &(*L)->prox;
     }
     *L = no(x, *L);
}

void ins_isr(Item x, Lista *L) {
    while(*L != NULL && (*L)->item<x) {
        L = &(*L)->prox;
    }
    if(*L == NULL || (*L)->item != x) {
        *L = no (x, *L);
    }
    else{
        printf("Esse item ja foi inserido\n");
    }
}
int main(void) {
    Lista I = NULL;
    int x;

    do{
		printf("Digita um numero: ");
        scanf("%d/n", &x);
        ins_isr(x, &I);
    }while(x != -1);
    
    exibe(I);
    
    return 0;
}
