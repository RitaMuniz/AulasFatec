#include <iostream>

//NÃO FUNCIONA
/* run this program using the console pauser or add your own getch, system("pause") or input loop */
/*Criar um vetor de 10 elementos e uma matriz de 10 linhas por 10 colunas
· solicitar para o usuário digitar valores no intervalo de 1 a 10 e inserir no vetor,
· após a inserção no vetor, ler o vetor e para cada elemento lido calcular a tabuada e inserir na matriz.
· Ao final mostrar o elemento do vetor e a tabuada correspondente que esta na matriz*/

using namespace std;
int main(int argc, char** argv) {
	
	int veta[10], mata[10][10], x=0, y=0, n=1;
	
	for(x=0; x<=9; x=x+1)
	{
		veta[x]=0;
	}
	
	for(x=0;x<=9;x=x+1)
	{
		for(y=0; x<=9;x=x+1)
		{
			mata[x][y]=0;
		}
	 } 
	 
	 cout<<"Multiplicação\n";
	 cout<<"Digite 10 valores entre 1 e 10 e aparecará a tabuada de cada valor digitado\n";
	 cout<<"------------------------------------------------------------------------------\n";
	 
	for(x=0;x<=9;x=x+1)
	{
			do
			{
				cout<<"Digite valor "<<n<<": ";
				cin>>veta[x];
			} while(x<0 || x>10);
		n=n+1;
	 } 
	

	for(x=0;x<=9;x=x+1)
	{
		n=1;
		
		for(y=0; x<=9;x=x+1)
		{
			mata[x][y]=veta[x]*n;
			n=n+1;
		}
	 } 
	 
	for(x=0; x<=9; x=x+1) 	
	{
		n=1;
		cout<<"\n------------------------------------------------------------------------------\n";
		cout<<"Tabuada do "<<veta[x]<<"\n\n";
		
		for(y=0; y<=9; y=y+1)
		{
			cout<<veta[x]<<" * "<<n<<" = "<<mata[x][y]<<"\n";
			n=n+1;
		}
		
		cout<<"\n------------------------------------------------------------------------------\n";	
	 } 
	
	return 0;
}
