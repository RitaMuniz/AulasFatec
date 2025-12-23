#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 12 ao 16

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

void preordem(Arv A) {
    if (A == NULL) return;
    printf("%d ", A->item);
    preordem(A->esq);
    preordem(A->dir);
}

void emordem(Arv A) {
    if (A == NULL) return;
    emordem(A->esq);
    printf("%d ", A->item);
    emordem(A->dir);
}

void posordem(Arv A) {
    if (A == NULL) return;
    posordem(A->esq);
    posordem(A->dir);
    printf("%d ", A->item);
}

void eoi(Arv A) {
    if (A == NULL) return;
    eoi(A->dir);
    printf("%d ", A->item);
    eoi(A->esq);
}

int main(void) {
    srand(time(NULL));
    Arv A = completa(3);
    
    printf("Arvore binaria: \n");
	exibe(A, 0);

    printf("\nPre-ordem: ");
    preordem(A);

    printf("\nEm ordem: ");
    emordem(A);

    printf("\nPos-ordem: ");
    posordem(A);

    printf("\nInversa: ");
    eoi(A);
    
    
    return 0;
}
