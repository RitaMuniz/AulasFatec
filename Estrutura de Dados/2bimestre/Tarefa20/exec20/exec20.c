#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 20

typedef int Item;
typedef struct arv {
        struct arv *esq;
        Item item;
        struct arv *dir;
}*Arv;

Arv arv(Arv e, Item x, Arv d) {
    Arv n = (Arv) malloc(sizeof(struct arv));
    n->esq = e;
    n->item = x;
    n->dir = d;
    return n;
}

void exibe(Arv A, int n) {
     if(A==NULL) return;
     exibe(A->dir, n+1);
     printf("%*s%d\n", 3*n, "", A->item);
     exibe(A->esq, n+1);
}

Arv completa(int h) {
    if(h==0) return NULL;
    return arv(completa(h-1), rand()%100, completa(h-1));
}

Arv balanceada(int n) {
    
}

int iguais (Arv A, Arv B) {
if (A == NULL && B == NULL) return 1;
    if (A == NULL || B == NULL) return 0;
    if (A->item != B->item) return 0;

    return iguais(A->esq, B->esq) && iguais(A->dir, B->dir);
}

int main(void) {
    srand(time(NULL));
    Arv A = completa(3);
    Arv B = completa(3);
   
    printf("Arvore A: \n");
    exibe(A, 0);
    printf("\nArvore B: \n");
    exibe(B, 0);
    
    if (iguais(A, B)) {
    	printf("\nAs arvores sao iguais!\n");
	}
	
	else {
    	printf("\nAs arvores sao diferentes.\n");
	}
	
    return 0;
}
