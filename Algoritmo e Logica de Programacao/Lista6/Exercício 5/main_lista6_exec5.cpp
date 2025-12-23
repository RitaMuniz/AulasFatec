#include <iostream>

//NÃO TÁ FUNCIONANDO

/* run this program using the console pauser or add your own getch, system("pause") or input loop */
/*Criar um matriz A 2x2 do tipo inteiro
· Solicitar p/ o usuário os valores inteiro positivo (consistir) e inserir na matriz A
· Criar uma matrizB 2x2 do tipo inteiro
· Gravar na matrizB o fatorial de cada elemento da matrizA
· Mostrar as matrizes*/

using namespace std;
int main(int argc, char** argv) {
	
	//Variaveis
	int mata[2][2], matb[2][2], x=0, y=0, n=1, d=0;
	
	for(x=0;x<=1;x=x+1)
	{
		for(y=0;y<=1;y=y+1)
		{
			mata[x][y]=0;
			matb[x][y]=0;
		}
	}
	
	
	
	for(x=0;x<=1;x=x+1)
	{
		for(y=0;y<=1;y=y+1)
		{
			do{
				cout<<"Digite valor "<<n<<": ";
				cin>>mata[x][y];
			}
			while(mata[x][y]<=0);
			
			n=n+1;
		
		}	
	}
	
	for(x=0;x<=1;x=x+1)
	{
		for(y=0;y<=1;y=y+1)
		{
			d=mata[x][y];
			
			while(n>=1)
			{
				n=d-1;
				d=d*n;
			}

			matb[x][y]=d;
		}
	}
	
	for(x=0;x<=1;x=x+1)
	{
		for(y=0;y<=1;y=y+1)
		{
			cout<<mata[x][y]<<"\n";
		}
	}
	
	cout<<"\n";
	
	for(x=0;x<=1;x=x+1)
	{
		for(y=0;y<=1;y=y+1)
		{
			cout<<matb[x][y]<<"\n";
		}
	}
	return 0;
}
