#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {
	
	short a;
	short x;
	
	x=0;
	
	for(a=4; a>-3; a--){
		x += a;
		
		switch(a>0) {
		
			case 1: 
			x= x+a;
			break;
			
			case 0:
			x = x-2*a;
			break;
		}
	}
	printf("%d\n", x);	
	
	return 0;
}
