#include<stdio.h>
#include<stdlib.h>

//Rita de Cassia Muniz de Lima
//Exemplo 14: Média de uma sequencia de numeros

//Funcao media
float media(float v[], int n) {
	//Variaveis
    float s=0;
    int i=0;
    
    //Loop
	for(i=0; i<n; i++) {
		s+= v[i]; 						 //soma valor contido em s com valor contido dentro do vetor
	}
	
	return s/n;	  						 //retorna soma dividido pela quantidade de valores do vetor
}

//Funcao principal
int main (void) {
	
	//Variaveis
    int n;
    
    //Usuario
    printf("Media\n");
    printf("Quantos valores serão usados para calcular a media: ");
    scanf("%d", &n); 				  	 //Pega quantidade de numeros que serao usados na media
    
    
    float *v = malloc(n*sizeof(float));  //Cria ponteiro para receber valor dinamico que será separado na memoria enquanto codigo esta sendo executado
    
    //loop para pegar valores para calcular media
	int i=0;
    for(i=0; i<n; i++) {
    	printf("Valor %d: ", i+1);
        scanf("%f", &v[i]);				//Armazena valor no vetor
    }
    
    //Resposta
    printf("Media: %.2f", media(v,n)); //chama media
    
    return 0;
}
