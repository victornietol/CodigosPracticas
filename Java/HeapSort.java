package org.example.estructurasDatos.ejercicios;

import java.util.Arrays;
import java.util.List;

public class HeapSort {
    public static void main(String[] args) {
        int[] array = {4, 10, 3, 5, 1};
        heapSort(array);
        System.out.println(Arrays.toString(array));
    }

    /**
     * Max heap. El mayor es el elemento nodo
     * @param array Elementos
     * @param i Es el indice del nodo actual
     * @param size Tamaño actual del heap
     */
    private static void heapify(int[] array, int i, int size) {
        int largest = i;
        int left = 2*i + 1;
        int right = 2*i + 2;

        // comparar al nodo con los dos hijos y colocar al elemento mas grande como nodo
        if (left < size && array[left] > array[largest]) {
            largest = left;
        }
        if (right < size && array[right] > array[largest]) {
            largest = right;
        }

        if (largest != i) { // si es necesario intercambiar nodo por algun hijo debido a la comparacion anterior
            int aux = array[i];
            array[i] = array[largest];
            array[largest] = aux;

            heapify(array, largest, size);
        }
    }

    /**
     * Construir heap
     * @param array
     */
    private static void buildHeap(int[] array) {
        // formula para obtener ultimo nodo interno: (n/2)-1
        int n = array.length;
        for (int i=(n/2)-1; i>=0; i--) {
            heapify(array, i, n);
        }
    }

    public static void heapSort(int[] array) {
        buildHeap(array);

        for (int i=array.length-1; i>0; i--) {
            int aux = array[0]; // Se intercambia el primer elemento por el ultimo porque el primero es el nodo, es decir, elemento mayor, esto como resultado de buildHeap
            array[0] = array[i];
            array[i] = aux;

            heapify(array, 0, i); // restaurar heap
        }
    }
}
