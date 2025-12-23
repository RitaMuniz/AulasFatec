#include <iostream>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

/*Criar um vetor A do tipo inteiro de 5 elementos
· Solicitar os valores para o usuário e inserir no vetor A
· Criar um vetor B do tipo inteiro
· Ler o vetor A e para cada elemento lido calcular o fatorial e gravar no B
· Após de todos os elementos do vetor A, mostrar os dois vetores*/

using namespace std;
int main(int argc, char** argv) {
	
	//variaveis
	int veta[5], vetb[5], n=0, d=0;
	
	//zerar os elementos dos vetores
	for(n=0;n<=4;n=n+1)
	{
		veta[n]=0;
		vetb[n]=0;
	}
	
	cout<<"fatoriais\n";
	cout<<"Digitar 5 numeros positivos e sera mostrado o fatorial de cada um\n\n";
	
	
	//armazena o numero do usuario
	n=0;
	do
	{
		cout<<"Digite o numero positivo : ";
		cin>>veta[n];
		n=n+1;
	}
	while(n<=4);
	
	//zera n pra funcionar o código
	n=0;
	
	do
	{
		//transforma vetb em veta e traz uma variavel para ser o numero anterior (não funciona com 1)
		
		vetb[n]=veta[n];
		d=veta[n]-1;
			
			do{
			
				//aqui faz a multiplicação do fatorial, onde vetb e multiplicado pelo numero anterior
				
				vetb[n]=vetb[n]*d;
				d=d-1;
			}
			while(d>=1);
		
		n=n+1;
	}
	while(n<=4);
	
	cout<<"\n--------------------------------\n";
	
	n=0;
	do
	{
		cout<<veta[n]<<" em fatorial eh igual a: "<<vetb[n]<<"\n";
		n=n+1;
	}
	while(n<=4);
	
	return 0;
}
