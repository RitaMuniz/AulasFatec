#include <iostream>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

/*Criar um vetor A de 15 elementos
· Solicitar um valor inteiro positivo na base decimal
· Transformar em binário e para binário calculado inserir no vetor A
· Após o cálculo mostrar o binário na ordem correta
· OBS:Mostrar somente os elementos inseridos*/

using namespace std;
int main(int argc, char** argv) {
	
	//variaveis
	int veta[15], n=0, d=0;
	
	cout<<"Decimal para binario \n\n";
	
	//colocando -1 em todos os elementos do vetor
	for(n=0;n<=14;n=n+1)
	{
		veta[n]=-1;
	}
	
	//para so aceitar numero positivo
	do
	{
		cout<<"Digite um numero positivo: ";
		cin>>d;
	}
	while(d<0);
	
	//fazer a divisão enquanto d>1
	do
	{				
		veta[n]=d%2;
		d=d/2;
		n=n+1;
	}
	while(d>1);
	//assim, só irá modifcar os elementos necessários para formar o binerio(se fosse com for, o resto ficaria com 0
	
	
	//se não deixar o veta[n]=d, dá bug no resultado
	veta[n]=d;
	
	cout<<"Em binario fica: \n";
	
	for(n=n;n>=0;n=n-1)
	{
		//quando ele chegar no elemento com -1, o código não faz nada, ou seja, so aparece o binario
		if(veta[n]==-1)
		{
			
		}
		//1 fica 01 e 0 fica 00 ainda
		else
		{
			cout<<veta[n]<<"\n";
		}
	}

	return 0;
}
