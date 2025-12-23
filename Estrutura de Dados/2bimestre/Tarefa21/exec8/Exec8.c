#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h> 

typedef int Item;

typedef struct arv {
    struct arv *esq;  
    int item;         
    struct arv *dir;  
} *Arv;

Arv arv(Arv e, int x, Arv d) {
    Arv n = malloc(sizeof(struct arv));
    n->esq = e;
    n->item = x;
    n->dir = d;
    return n;
}

void exibe(Arv A, int n) {
    if (A == NULL) return;
    exibe(A->dir, n + 1);                      
    printf("%*s%d\n", 3 * n, "", A->item);     
    exibe(A->esq, n + 1);       
}

Arv completa(int h) {
    if (h == 0) return NULL; 
    return arv(completa(h - 1), rand() % 100, completa(h - 1));
}

void destroi(Arv *A) {
    if (*A == NULL) return;
    destroi(&(*A)->esq);
    destroi(&(*A)->dir);
    free(*A);
    *A = NULL;
}

void ins(Item x, Arv *A){
    if( *A == NULL) *A = arv(NULL, x, NULL);
    else if( x <= (*A)-> item) ins(x, &(*A)->esq);
    else ins(x, &(*A)->dir);
}

void emordem(Arv A) {
    if (A == NULL) return;
    emordem(A->esq);
    printf("%d ", A->item);
    emordem(A->dir);
}

int busca(Item x, Arv A){
    if( A == NULL) return 0;
    if( x == A->item) return 1;
    if( x < A->item) return busca(x, A->esq);
    else return busca(x, A->dir);
}

Item remmax(Arv *A){
    if( *A == NULL) abort();
    if( (*A)->dir == NULL){
        Arv n = *A;
        Item x = n->item;
        *A = n->esq;
        free(n);
        return x;
    }
    return remmax(&(*A)->dir);
}

void remraiz(Arv *A){
    if( *A == NULL) abort();
    Arv n = *A;
    if( n->esq == NULL) *A = n->dir;
    else if( n->dir == NULL) *A = n->esq;
    else n->item = remmax(&n->esq);
    if(n != *A ) free(n);
}

void rem(Item x, Arv *A){
    if( *A == NULL) return;
    if( x == (*A)->item) remraiz(A);
    else if( x < (*A)->item) rem(x, &(*A)->esq);
    else rem(x, &(*A)->dir);
}

void ins_sr(Item x, Arv *A) {
    if (*A == NULL) {
        *A = arv(NULL, x, NULL);
        return;
    }
    if (x == (*A)->item) return;
    if (x < (*A)->item) 
        ins_sr(x, &(*A)->esq);
    else 
        ins_sr(x, &(*A)->dir);
}

int main(void) {
    int v[12] = {71, 43, 64, 92, 80, 27, 58, 35, 16, 43, 92, 27};
    Arv A = NULL;

	int i = 0;
    for (i = 0; i < 12; i++) 
        ins_sr(v[i], &A);

    puts("Arvore sem valores repetidos:");
    exibe(A, 0);

    puts("\nEm ordem:");
    emordem(A);
    putchar('\n');

    destroi(&A);
    return 0;
}




