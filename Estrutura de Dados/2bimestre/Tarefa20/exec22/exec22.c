#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 22

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



int espelho (Arv A, Arv B) {
	if (A == NULL && B == NULL) return 1;
    if (A == NULL || B == NULL) return 0;
    if (A->item != B->item) return 0;

    return espelho(A->esq, B->dir) && espelho(A->dir, B->esq);
}

int main(void) {
    srand(time(NULL));
    Arv A = completa(3);
    Arv B = completa(3);
    
    printf("Arvore A: \n");
    exibe(A, 0);
    
    printf("Arvore B: \n");
    exibe(B, 0);
    
    if (espelho(A, B)) {
        printf("\nB e espelho de A!\n");
    }
    else {
        printf("\nB nao e espelho de A.\n");
	}
	return 0;
}
