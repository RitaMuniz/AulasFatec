#include<stdio.h>
#include<stdlib.h>
#include<string.h>

//Rita de Cassia Muniz de Lima
//Exercicio 3

typedef char Chave[22];
typedef char Valor[22];

//Criaçãp do mapeamento
typedef struct map {
	Chave chave;
	Valor valor;
	struct map *prox;
}*Map;

//Criação de nos
Map no_map(Chave c, Valor v, Map p) {
	Map n = (Map)malloc(sizeof(struct map));
	
	strcpy(n->chave,c);
	strcpy(n->valor,v);
	n->prox=p;
	
	return n;
}

//Criar inserção de valores
void insm(Chave c, Valor v, Map *M) {
	while(*M && c>(*M)->chave) {
		M = &(*M)->prox;
	}
	if(*M && c==(*M)->chave){
		strcpy((*M)->valor,v);
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
        strcpy((*M)->valor, v);
    }
    else {
        insmr(c, v, &((*M)->prox));
    }
}

//Exibir mapeamento
void exibem(Map M) {
	printf("[");
	while(M) {
		printf("(%s, %s)", M->chave, M->valor);
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

//Dicionarios
unsigned hash(char *c, int m) {
	unsigned s=0;
	int i;
	for( i=0; c[i]; i++){
		s += (i+1)*c[i];
	}
	return (s % m );
}

typedef struct dic {
	int tam;
	Map *vet;
}*Dic;

Dic dic(int m) {
	Dic d = (Dic)malloc(sizeof(struct dic));
	d->tam = m;
	d->vet = malloc(m*sizeof(Map));
	
	int i;
	for(i=0; i<m; i++) {
		d->vet[i] = NULL;
	}
	return d;
}

void insd(Chave c, Valor v, Dic d){
	insm(c, v, &d->vet[hash(c,d->tam)]);
}

void remd(Chave c, Dic d) {
	remm(c, &d->vet[hash(c, d->tam)]);
}

int pertd(Chave c, Valor v, Dic d) {
	return pertm(c, v, d->vet[hash(c,d->tam)]);
}

void exibed(Dic d){
	
	int i;
	for(i=0; i<d->tam; i++) {
		printf("%d: ", i);
        exibem(d->vet[i]);
	}
}

void destroid(Dic *d){
	
	int i;
	for(i=0; i<(*d)->tam; i++){
		destroim(&(*d)->vet[i]);
        free(*d);
        *d = NULL;
    }    
}

int main(void){
    Dic D=dic(3);
    insd("bat","morcego",D); insd("pig","porco",D);
    insd("cat","gato",D); insd("dog","cachorro",D);
    insd("cow","vaca",D);
    
	printf("Dicionario:\n");
	exibed(D);
    return 0;
}
