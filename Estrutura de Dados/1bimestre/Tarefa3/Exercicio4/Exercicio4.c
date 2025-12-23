#include<stdio.h>
#include "pilha.h"

//Rita de Cassia Muniz de Lima
// Exercicio 4: Balanceamento de parênteses


// Função para verificar se o símbolo de fechamento corresponde ao de abertura
int verifica(char car, char topo) {
    return (car == '}' && topo == '{') ||
           (car == ']' && topo == '[') ||
           (car == ')' && topo == '(');
}

int main(void) {
    // Variáveis
    char f[256];
    int i;
    Pilha A = pilha(256);  // Pilha para armazenar os símbolos de abertura
    
    printf("Balanceamento\n");
    printf("Digite a sequencia de parentes, colchetes e chaves: ");
    fgets(f, sizeof(f), stdin); 

    // Remove a nova linha, se houver
    f[strcspn(f, "\n")] = '\0';

    // Empilha os símbolos de abertura e processa os símbolos de fechamento
    for (i = 0; f[i]; i++) {
        if (f[i] == '(' || f[i] == '{' || f[i] == '[') {
            empilha(f[i], A);  // Empilha apenas se for um símbolo de abertura
        } else if (f[i] == ')' || f[i] == '}' || f[i] == ']') {
            if (vaziap(A)) {  // Se a pilha estiver vazia e encontrar um fechamento, está desbalanceado
                printf("NAO esta balanceado\n");
                return 0;
            }
            char topoPilha = desempilha(A);  // Desempilha o topo da pilha
            if (!verifica(f[i], topoPilha)) {  // Verifica se o par fecha corretamente
                printf("NAO esta balanceado\n");
                return 0;
            }
        }
    }

    // Se a pilha estiver vazia no final, está balanceado
    if (vaziap(A)) {
        printf("Esta balanceado\n");
    } else {
        printf("NAO esta balanceado\n");
    }

   
    destroip(&A);
    return 0;
}

