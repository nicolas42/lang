#include <stdio.h>

int factorial(int a){
	if (a==1){return 1;}
	return a * factorial(a-1);
}

int main(int argc, char** argv){
	return factorial(argc);
}

