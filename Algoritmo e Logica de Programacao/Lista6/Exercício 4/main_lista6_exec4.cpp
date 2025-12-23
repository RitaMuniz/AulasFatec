#include <iostream>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */
/*Criar uma matriz A de 3 linhas e 3 colunas do tipo inteiro
· Solicitar p/ o usuário os valores para inserir na matriz A
· Criar um Vetor B de 3 elementos do tipo inteiro
· Gravar no vetor b a diagonal secundaria da matriz A
· Após a inserção do valores mostrar a matriz A e o vetor B*/

using namespace std;
int main(int argc, char** argv) {
	
	//variaveis
	int mata[3][3], vetb[3], x=0,y=0, n=1;
	
	for(x=0;x<=2;x=x+1)
	{
		for(y=0;y<=2;y=y+1)
		{
			mata[x][y]=0;
		}
	}
	
	for(x=0;x<=2;x=x+1)
	{
		vetb[x]=0;
	}
	
	//inserindo valores
	
	cout<<"Diagonal secundaria\n";
	
	for(x=0;x<=2;x=x+1)
	{
		for(y=0;y<=2;y=y+1)
		{
			cout<<"Digite valor "<<n<<": ";
			cin>>mata[x][y];
			n=n+1;
		}
	}
	
	y=2;
	for(x=0;x<=2;x=x+1)
	{
		vetb[x]=mata[x][y];
		y=y-1;
	}
	
	//mostrando valores
	cout<<"A matriz fica: \n";
	
	for(x=0;x<=2;x=x+1)
	{
		for(y=0;y<=2;y=y+1)
		{
			cout<<" | "<<mata[x][y]<<" | ";
		}
		cout<<"\n";
	}
	
	cout<<"\n a diagonal secundaria: \n";
	for(x=2;x>=0;x=x-1)
	{
		cout<<" | "<<vetb[x]<<" | ";
	}
	
	return 0;
}
