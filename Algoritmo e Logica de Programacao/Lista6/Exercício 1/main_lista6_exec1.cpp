#include <iostream>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

/*Criar uma matriz A de 2 linhas e 2 colunas do tipo inteiro
· Solicitar para o usuário os valores para inserir na matriz A
· Após a inserção dos valores, mostrar a matriz A*/

using namespace std;
int main(int argc, char** argv) {
	
	int mata[2][2], x=0, y=0, n=1;
	
	for(x=0;x<=1;x=x+1)
	{
		for(y=0;y<=1; y=y+1)
		{
			mata[x][y]=0;
		}
	}
	
	cout<<"Matriz\n";
	
	for(x=0;x<=1;x=x+1)
	{
		for(y=0;y<=1; y=y+1)
		{
			cout<<"Digite valor "<<n<<": ";
			cin>>mata[x][y];
			
			n=n+1;
		}
	}
	
	cout<<"Os valores na matriz ficaram: \n";
	for(x=0;x<=1;x=x+1)
	{
		for(y=0;y<=1; y=y+1)
		{
			cout<<" | "<<mata[x][y]<<" | ";
		}
		
		cout<<"\n";
	}
	
	return 0;
}
