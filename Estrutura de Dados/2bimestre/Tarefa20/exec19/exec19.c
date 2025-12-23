#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 19

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

int conta(Item x, Arv A) {
    if (A == NULL) return 0;

    int soma = 0;
    if (A->item == x) soma = 1;

    return soma + conta(x, A->esq) + conta(x, A->dir);
}

int main(void) {
    srand(time(NULL));
    Arv A = completa(3);
    exibe(A, 0);
    
    int v = 7;
    printf("\nO numero %d aparece %d vezes na arvore.\n", v, conta(v, A));
    
    return 0;
}
