#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h> 

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

int main() {
    Arv A = arv(arv(arv(arv(NULL, 0, arv(NULL, 1, NULL)), 2, arv(NULL, 3, NULL)), 4, arv(arv(NULL, 5, NULL), 6, NULL)), 7, arv(arv(NULL, 8, arv(arv(NULL, 9, NULL), 10, NULL)), 11, NULL)); 
    exibe(A, 0);
    destroi(&A);

    return 0;
}