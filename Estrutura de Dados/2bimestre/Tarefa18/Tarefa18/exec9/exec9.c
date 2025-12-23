#include<stdio.h>
#include<stdlib.h>
#include<string.h>

//Rita de Cassia Muniz de Lima
//Exercicio 9

typedef int Chave;
typedef int Valor;

//Criaçãp do mapeamento
typedef struct map {
	Chave chave;
	Valor valor;
	struct map *prox;
}*Map;

//Criação de nos
Map no_map(Chave c, Valor v, Map p) {
	Map n = (Map)malloc(sizeof(struct map));
	
	n->chave=c;
	n->valor=v;
	n->prox=p;
	
	return n;
}

//Criar inserção de valores
void insm(Chave c, Valor v, Map *M) {
	while(*M && c>(*M)->chave) {
		M = &(*M)->prox;
	}
	if(*M && c==(*M)->chave){
		(*M)->valor = v;
	}
	else {
		*M = no_map(c,v,*M);
	}
	
}

//Inserçao recursiva
void insmr(Chave c, Valor v, Map *M) {
    if (*M == NULL || c < (*M)->chave) {
        *M = no_map(c, v, *M);
    }
    else if (c == (*M)->chave) {
        (*M)->valor = v;
    }
    else {
        insmr(c, v, &((*M)->prox));
    }
}

//Exibir mapeamento
void exibem(Map M) {
	printf("[");
	while(M) {
		printf("(%d, %d)", M->chave, M->valor);
		if(M->prox) {
			printf(", ");
		}
		M = M->prox;
	}
	printf("]\n");
}

//Remoção
void remm (Chave c, Map *M) {
	while (*M && c>(*M)->chave) {
		M= &(*M)->prox;
	}
	
	if(*M==NULL || c!=(*M)->chave) {
		return;
	}
	
	Map n=*M;
	*M=n->prox;
	free(n);
}

void remmr(Chave c, Map *M) {
    if (*M == NULL) return;

    if (c < (*M)->chave) {
        return;
    } else if (c == (*M)->chave) {
        Map n = *M;
        *M = n->prox;
        free(n);
    } else {
        remmr(c, &(*M)->prox);
    }
}

int pertm(Chave c, Valor v, Map M) {
    while(M && c>M->chave) {
            M = M -> prox;
    }
    if(M && c==M->chave) {
         strcpy(v, M->valor);
    }
    return (M && c==M->chave);
}

int pertmr(Chave c, Valor v, Map M) {
    if (!M) return 0;
    
    if (M && M->chave == c) {
          strcpy(v, M->valor);
          return 1;
    }
    
    return pertmr(c, v, M->prox);
}

void destroim (Map M) {
	
	while (M) {
		Map n = M;
		M = n->prox;
		free(n);
	}
}

void destroimr(Map M) {
    if (M) {
        destroimr(M->prox);
        free(M);
    }
}



int main(void) {
	Map I = NULL;
	Valor w;
	insmr(36, 63, &I); insmr(15, 51, &I);
	insmr(42, 24, &I); insmr(29, 92, &I);
	
	printf("Mapeamento: ");
	exibem(I);
	
	destroimr(&I);
	return 0;
}
