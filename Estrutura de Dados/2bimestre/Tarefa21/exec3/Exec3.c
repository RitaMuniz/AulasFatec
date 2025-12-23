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

int main(void) {
    Arv I = NULL;
    Item x;
    puts("\nPara sair, digite um inteiro negativo!\n");
    while (1) {
        printf("Item a ser inserido? ");
        scanf("%d", &x);
        if (x < 0) break;
        ins(x, &I);
    }
    exibe(I, 0);
    return 0;
}
