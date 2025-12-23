#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exercicio 6

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

void ins_rec(Item x, Lista *L) {
    if(*L != NULL && (*L)->item>x) {
        *L = no(x, *L);
    }
    if(*L == NULL) {
        *L = no(x, *L);
    }
    if(*L != NULL && (*L)->item<x) {
        ins_rec(x, &(*L)->prox);
    }
}

void exiba_ri(Lista L) {
    if(L == NULL) {
		return;
	}
	exiba_ri(L->prox);
    printf("%d, ", L->item);
}

int main(void) {
    Lista I = NULL;
    int x;

    do{
        printf("Digita um numero: ");
        scanf("%d/n", &x);
        ins_rec(x, &I);
    }while(x!=-1);
    
    exiba_ri(I);
    scanf("%d");
    return 0;
}
