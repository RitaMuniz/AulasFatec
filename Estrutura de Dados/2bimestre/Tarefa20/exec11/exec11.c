#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 11

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

int pertence(Item x, Arv A) {
    if (A == NULL) return 0;
    if (A->item == x) return 1;
    return pertence(x, A->esq) || pertence(x, A->dir); 
}

int main(void) {
    srand(time(NULL));
    Arv A = completa(3);
    
    printf("Arvore binaria: \n");
	exibe(A, 0);
    
    printf("\n5 pertence a arvore? %d \n", pertence(5, A));
    printf("\n15 pertence a arvore? %d \n", pertence(15, A));
    printf("\n0 pertence a arvore? %d \n", pertence(0, A));
    
    
    return 0;
}
