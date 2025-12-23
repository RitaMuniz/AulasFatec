#include<stdio.h>

//Rita de Cassia Muniz de Lima
//Exemplo 8: Grafico de barras

//Função para criação de barras
void barras(int v[], int n) {
	//Variaveis
	int i=0;
	int j=0;
	
	//loop para montar vetor que formará a barra
	for(i=0; i<n; i++) {
		for(j=0; j<v[i]; j++) {
			putchar(220); 	//usando caracteres para impressão das barras
		}
		putchar('\n');
	}
}

//Função principal
int main(void) {
	//variaveis
	int a[4] = {3, 4, 2, 1}; //Incluindo valores ao vetor
	int b[3] = {9, 4, 7};	 //incluindo valores ao vetor
	
	//Impressão
	barras(a,4);
	getchar();
	barras(b,3);
	
	return 0;
}
