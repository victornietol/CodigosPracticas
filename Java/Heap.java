package org.example.estructurasDatos.ejercicios;

import java.util.Arrays;

public class Heap {
    public static void main(String[] args) {
        int[] array = {9, 4, 7, 1, 0, 3};

        buildHeap(array);

        System.out.println(Arrays.toString(array));
    }

    /**
     * Construir Heap
     * @param array Arreglo con elementos originales
     */
    public static void buildHeap(int[] array) {
        // formula para obtener ultimo nodo interno: (n/2)-1
        int n = array.length;
        for (int i=(n/2)-1; i>=0; i--) {
            heapify(array, i);
        }
    }

    /**
     * Min Heapify. Ordena priorizando al menor
     * @param array Arreglo de elementos
     * @param i Indice del elemento a operar (nodo)
     */
    public static void heapify(int[] array, int i) {
        int smallest = i;
        int left = 2*i + 1;
        int right = 2*i + 2;

        // comparar al nodo con los dos hijos y colocar al elemento mas pequeño como nodo
        if (left < array.length && array[left] < array[smallest]) {
            smallest = left;
        }
        if (right < array.length && array[right] < array[smallest]) {
            smallest = right;
        }

        if (smallest != i) { // si es necesario intercambiar nodo por algun hijo debido a la comparacion anterior
            int aux = array[i];
            array[i] = array[smallest];
            array[smallest] = aux;

            heapify(array, smallest);
        }

    }
}
