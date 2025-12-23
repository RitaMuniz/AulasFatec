#include <stdio.h>
#include <stdlib.h>

/**/

void func1()
{
	int b;
	b=-100;
	printf("Valor B na func1: %d\n", b);
}

void func2()
{
	int b;
	b=-200;
	printf("Valor de B na func2: %d\n", b);

}

int main(int argc, char *argv[]) {
	
	int b;
	b=10;
	printf("Valor de b: %d\n", b);
	
	b=20;
	
	func1();
	printf("Valor de b: %d\n", b);
	
	b=30;
	
	func2();
	printf("Valor de b: %d\n", b);
	
	getch();
	
	
	
	return 0;
}
