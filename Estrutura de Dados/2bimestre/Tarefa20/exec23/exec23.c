#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 23

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

Arv balanceada(Item v[], int p, int u) {
    if (p > u) return NULL;

    int m = (p + u) / 2;

    return arv(
        balanceada(v, p, m - 1),  // esquerda
        v[m],                    // raiz
        balanceada(v, m + 1, u)   // direita
    );
}

int main(void) {
    Item v[] = {2, 4, 7, 10, 12, 15, 20, 25, 30};
    int n = sizeof(v) / sizeof(v[0]);

    Arv A = balanceada(v, 0, n - 1);

    printf("Arvore balanceada:\n");
    exibe(A, 0);

    return 0;
}
