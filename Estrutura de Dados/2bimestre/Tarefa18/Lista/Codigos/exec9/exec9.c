#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 9

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

int main() {
    Lista I = NULL;
    ins(4, &I);
    ins(1, &I);
    ins(3, &I);
    ins(2, &I);
    exibe(I);
    printf("\n5 pertence a lista ordenada? (0:nao 1:sim) %d\n", pert(5, I));
    printf("3 pertence a lista ordenada? (0:nao 1:sim) %d\n", pert(3, I));
    
    return 0;

}
