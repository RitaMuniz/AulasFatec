#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 8

typedef int Item;

typedef struct no {
	Item item;
	struct no *prox;
} *Lista;

Lista no(Item x, Lista p) {
      Lista n = malloc(sizeof(struct no));
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
              L = &((*L)->prox);
     }
     *L = no(x, *L);
}

//pertinencia n lista ordenada
int pert(Item x, Lista L) {
    while(L != NULL && L->item<x) {
    	L = L->prox;
    }
    return(L!=NULL && L->item==x);
}

void rem(Item x, Lista *L) {
	while(*L != NULL && (*L)->item<x) {
		L = &(*L)->prox;
	}
	if(*L == NULL || (*L)->item>x) {
		return;
	}
	Lista n = *L;
	*L = n->prox;
	free(n);
}

void rem_todo(Item x, Lista *L) {
    while (*L != NULL) {
        if ((*L)->item == x) {
            Lista temp = *L;
            *L = (*L)->prox;
            free(temp);
        } else {
            L = &(*L)->prox;
        }
    }
}

int main() {
    Lista I = NULL;
    printf("Lista: ");
    ins(4, &I); ins(1, &I); ins(3, &I); ins(2, &I); ins(3, &I);
    exibe(I);
    printf("\nLista sem 3: ");
    rem_todo(3, &I);
    exibe(I);
    
    return 0;

}
