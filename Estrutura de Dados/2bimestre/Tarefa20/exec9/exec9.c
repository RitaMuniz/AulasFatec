#include<stdio.h>
#include<stdlib.h>
#include<time.h>

//Rita de Cassia Muniz de Lima
//Exercicio 9

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
    if (n == 0) return NULL;

    int ne = n / 2;
    int nd = n - ne - 1;

    return arv(balanceada(ne), rand() % 100, balanceada(nd));
    
}

Arv aleatoria (int n) {
    if (n == 0) return NULL;

    int k = rand()%n;
	int ne = k;
    int nd = n - 1 - k;

    return arv(aleatoria(ne), rand() % 100, aleatoria(nd));
}

int nos(Arv A) {
	if (A == NULL) return 0;
    return 1 + nos(A->esq) + nos(A->dir);
}

int soma(Arv A) {
	if (A == NULL) return 0;
    return A->item + soma(A->esq) + soma(A->dir);
}

int folhas(Arv A) {
  	if (A == NULL) return 0;
    if (A->esq == NULL && A->dir == NULL) return 1;
    return folhas(A->esq) + folhas(A->dir);
}

int altura(Arv A) {
if (A == NULL) return 0;
    int he = altura(A->esq);
    int hd = altura(A->dir);
    return 1 + (he > hd ? he : hd);
}

int main(void) {
    srand(time(NULL));
    Arv A = balanceada(9);
    
    printf("Arvore binaria: \n");
    exibe(A, 0);
    
    printf("Altura na arvore: %d\n", altura(A));
    
    return 0;
}
