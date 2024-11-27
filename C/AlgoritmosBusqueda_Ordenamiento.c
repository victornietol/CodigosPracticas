#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

int* generar_lista();
bool enLista();

int main() {
    int* lista = generar_lista(20,1,1,200);
    for(int i=0; i<20; i++) {
        printf("%d ", lista[i]);
    }

    return 0;
}

int* generar_lista(int num_elementos, int repeticion, int min, int max) {
    int lista[num_elementos];
    if(repeticion == 0){
        int total_e = max+1 - min;
        if(num_elementos <= total_e) {
            bool repetido = false;
            for(int e=0; e<num_elementos; e++) { // e -> indice del elemento en el arreglo
                srand(time(0)); // numero random
                int elemento = (rand() % (max - min +1)) +min; // numero random
                if(enLista(lista, elemento)) { // Veriicar que el elemento este en la lista
                    repetido = true;
                    while(repetido == true) {
                        elemento = (rand() % (max - min +1)) +min;
                        if(enLista(lista, elemento)) {
                            lista[e] = elemento;
                            repetido = false;
                        }
                    }
                } else {
                    lista[e] = elemento;
                }
            }
        } else {
            printf("El numero de elementos a generar excede el valor del intervalo de min y max");
        }
    } else if (repeticion == 1) {
        for(int e=0; e<num_elementos; e++) {
            srand(time(0));
            lista[e] = (rand() % (max - min +1)) +min;
        }
        return lista;
    } else {
        printf("Valor incorrecto para el parametro 'repeticion'");
    }
}

// Funcion para verificar si el elmento esta en lista
bool enLista(int lista[], int elemento) {
    int longitud = sizeof(lista) - sizeof(lista[0]);
    for(int i=0; i<=longitud; i++) {
        if(lista[i] == elemento) {
            return true;
        } else {
            return false;
        }
    }
}