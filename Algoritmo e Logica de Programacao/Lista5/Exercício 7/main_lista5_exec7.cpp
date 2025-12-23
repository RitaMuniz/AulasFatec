#include <iostream>

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

/*Criar um vetor A de 20 elementos do tipo inteiro
· Solicitar para o usuário um número do termo da série de fibonacci
· Calcular a série até o termo informado e para cada termo calculado inserir no vetor A
· Após a inserção mostrar o vetor A ( somente a serie calculada)*/

using namespace std;
int main(int argc, char** argv) {
	
	//variaveis
	int veta[20], n=0, f=0, a=0, b=0;
	
	for(n=0;n<=19;n=n+1)
	{
		veta[n]=0;
	}
	
	cout<<"";
	
	do
	{
		cout<<"Digita: ";
		cin>>f;
	}
	while(f<2);
	
	//coloca um termo a menos pq o vetor começa em 0
	f=f-1;	
	veta[0]=1;
	veta[1]=1;
	
	//já temos os vetor 0 e 1
	
	n=2;	
	do
	{
		a=n-1;
		b=n-2;
		veta[n]=veta[a]+veta[b];
		n=n+1;
	}
	while(n=f);
	
	n=0;
	do
	{
		cout<<"Fibonnatti: "<<veta[n]<<"\n";
		n=n+1;
	}
	while(n=f);
	return 0;
}
