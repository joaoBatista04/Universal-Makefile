#include <stdio.h>
#include "../include/teste1/teste1.h"

int main(){
    Quadrado *q = new_Quadrado(10);

    printf("Hello World!\n");

    printf("%d\n", retornaQuadradoTamanho(q));

    return 0;
}