#include <stdio.h>
#include <stdlib.h>

/**/

int quadrado(int);

int main(int argc, char *argv[]) {
	
	int s1, s2, s3;
	
	printf("Digite numero inteiro: ");
	scanf("%d", &s1);

	printf("Digite numero inteiro: ");
	scanf("%d", &s2);
	
	printf("Digite numero inteiro: ");
	scanf("%d", &s3);
	
	if(s1> 0 && s2>0 && s3>0 && (quadrado(s1)+quadrado(s2)==quadrado(s3) || quadrado(s2)+quadrado(s3)==quadrado(s1) || quadrado(s3)+quadrado(s1)==quadrado(s2)))
	{
		printf("%d %d %d podem formar um triangulo reto\n", s1,s2,s3 );
	}
	else
	{
		printf("%d %d %d nao podem formar um triangulo reto\n", s1,s2,s3 );
	}	
	return 0;
}

int quadrado(int n)
{
	return n*n;
}
