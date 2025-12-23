#include <iostream>

/*Fatorial de um valor informado ( consistir para maior que zero e menor que 14)*/

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

using namespace std;
int main(int argc, char** argv) {
	
	int n=0, d=0;
	
	cout<<"Fatorial\n";
	
	do
	{
		cout<<"Digite um numero entre 1 e 14: ";
		cin>>n;
	} 
	while(n<0 || n>14);
	
	d=n-1;
	
	do
	{	
		n=n*d;
		d=d-1;	
	}
	while(d>=1);
	
	cout<<"\n O resultado do fatorial eh: "<<n;
	
	return 0;
}
