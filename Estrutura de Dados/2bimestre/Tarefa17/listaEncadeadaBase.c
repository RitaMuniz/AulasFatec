#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//Arquivo com todas as funções sobre lista encadeada (do slide pelo menos)

typedef int Item;

typedef struct no {
	Item item;
	struct no *prox;
} *Lista;

//Função para instanciar uma lista com valor x, encadeada a uma lista p (escreva NULL se for a primeira)
Lista no(int x, Lista p) {
	Lista n = malloc(sizeof(struct no));
	n->item = x;
	n->prox = p;
	
	return n;
}

void exibe(Lista L) {
	printf("[");
	
	while (L != NULL) {
		(L->prox != NULL) ? printf("%d, ", L->item) :  printf("%d", L->item);
		L = L->prox;
	}
	
	printf("]");
}

int tamanho(Lista L){
	int tamanho = 0;
	while (L) {
		tamanho++;
		L = L->prox;
	}
	
	return tamanho;
}

int soma(Lista L) {
	int sum = 0;
	while (L) {
		sum += L->item;
		L = L->prox;
	}
	
	return sum;
}

//Gera uma lista de n elementos, com valor de 0 até m-1
Lista aleatoria(int n, int m) {
	Lista L = NULL;
	while (n>0) {
		L = no(rand()%m, L);
		n--;
	}
	
	return L;
}

//Retorna uma lista com elementos inteiros entre 1 e n
Lista intervalo(int n) {
	Lista L = NULL;
	
	while (n >= 1) {
		L = no(n, L);
		n--;
	}
	
	return L;
}


void anexa(Lista *A, Lista B) {
	if (!B) return;
	while (*A) {
		A = &(*A)->prox;
	}
	*A = B;
}

void destroiLista(Lista *L) {
	while (*L) {
		Lista n = *L;
		*L = n->prox;
		free(n);
	}
}

int ultimo(Lista L) {
	if (!L) puts("Erro fatal: lista vazia!"); abort;
	int ultimo;
	while (L) {
		ultimo = L->item;
		L = L->prox;
	}
	
	return ultimo;
}

int maximo(Lista L) {
	if (!L) puts("Erro fatal: lista vazia!"); abort;
	int max = L->item;
	while (L) {
		if(L->item > max) max = L->item;
		L = L->prox;
	}
	return max;
}

int pertence(int x, Lista L){
	while (L) {
		if (x == L->item)  {
			puts("\npertence!"); 
			return 1;
		}
		
		L = L->prox;
	}
	puts("\nnao pertence!");
	return 0;
}

Lista inversa(Lista L) {
	Lista lista = NULL;
	while (L) {
		lista = no(L->item, lista);
		L = L->prox;
	}
	return lista;
}

//Cria uma lista com todos os numeros inteiros entre [m, n]
Lista intervaloEntre(int m, int n) {
	Lista L = NULL;
	if (m > n) return L;
	while (m <= n) {
		L = no(n, L);
		n--;
	}
	return L;
}

//Funções Recursivas equivalentes ou novas vvv
int len(Lista L) {
	if (!L->prox) return 1;
	return 1+len(L->prox);
}

int sum(Lista L) {
	if (!L->prox) return L->item;
	return L->item+sum(L->prox);
}

//Clona recursivamente uma lista encadeada
Lista clone(Lista L) {
	if (!L) return NULL;
	return no(L->item, clone(L->prox));
}

Lista rnd(int n, int m) {
	if (n==1) return no(rand()%m, NULL);
	return no(rand()%m, rnd(n-1, m));
}

int last(Lista L) {
	if (!L->prox) return L->item;
	return last(L->prox);
}

int in(int x, Lista L) {
	if (x == L->item) {
		puts("\npertence");
		return 1;
	}
	if (!L->prox) {
		if(x != L->item) puts("\nnao pertence");
		return 0;
	}
	
	return in(x, L->prox);
}

//Retorna o enésimo (se houver) item de uma lista encadeada
int nth(int n, Lista L) {
	if (n == 1) return L->item;
	
	if (!L) {
		puts("\nErro fatal: n maior que a lista");
		exit(1);
	}
	
	return nth(n-1, L->prox);
}

int minimum(Lista L) {
	if (!L->prox) return L->item;
	
	int min = minimum(L->prox);
	if (L->item < min) return L->item;
	else return min; 
}

int sorted(Lista L) {
	if (!L->prox) return 1;
	
	if (L->item > L->prox->item) return 0;
	
	return sorted(L->prox);
}

int equal(Lista A, Lista B) {
	if (!A->prox && !B->prox) {
		if (A->item == B->item) return 1;
	}
	
	if ((A->prox && !B->prox) || (!A->prox && B->prox)) return 0;
	
	if (A->item != B->item) return 0;
	
	return equal(A->prox, B->prox);
}

int count(int x, Lista L) {
	if (!L->prox && x == L->item) return 1;
	
	if (x == L->item) return 1+count(x, L->prox);
	
	return count(x, L->prox);	
}

//Substitui da lista L todos os elementos com valor X pelo valor Y
void replace(int x, int y, Lista* L) {
	Lista lista = *L;
	if (lista->item == x) lista->item = y;
	
	if (!lista->prox) return;
	
	replace (x, y, &lista->prox);
}

int main(void) {
	srand(time(NULL));
	Lista A = no(5, no(10, no(9, no(3, no(5, no(5, NULL))))));
	printf("Lista A: \n");
	exibe(A);
	printf("\nSubstituindo 5 por 7 em A\n");
	replace(5, 7, &A);
	exibe(A);
	
	return 0;
}
