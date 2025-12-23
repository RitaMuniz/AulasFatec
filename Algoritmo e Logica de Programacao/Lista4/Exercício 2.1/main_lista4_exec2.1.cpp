#include <iostream>
/*Solicitar um valor inteiro positivo ( consistir) na base decimal e mostrar o binário.*/
/* run this program using the console pauser or add your own getch, system("pause") or input loop */

using namespace std;
int main(int argc, char** argv) {
	
	int n=0, d=0;
	
	cout<<"Decimal em Binario\n\n";
	
		do
		{
			cout<<"Digite um numero inteito positivo: ";
			cin>>n;
		}
		while(n<1);
	
	cout<<"O numero em binario(de tras para frente) eh: \n";
	
		while(n>1)
		{
			d=n%2;
			n=n/2;
			cout<<d<<"\n";
		}
	
	cout<<"1\n";
	
	return 0;
}
