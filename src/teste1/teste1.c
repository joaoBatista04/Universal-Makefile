#include "../../include/teste1/teste1.h"
#include <stdio.h>
#include <stdlib.h>

struct Quadrado{
    int tamanho;
};

Quadrado *new_Quadrado(int tamanho){
    Quadrado *q = (Quadrado *)malloc(sizeof(Quadrado));

    q->tamanho = tamanho;

    return q;
}

int retornaQuadradoTamanho(Quadrado *quadrado){
    return quadrado->tamanho;
}