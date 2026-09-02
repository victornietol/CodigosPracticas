package org.example.estructurasDatos.ejercicios.repasoAlgoritmos_basic;

import java.util.Arrays;

public class Repaso2_Resumen_Algoritmos {
    public static void main(String[] args) {
        int[] array = {75, 77, 40, 25, 65, 11, 37, 79, 85, 30, 40, 73, 87, 16, 19, 78, 56, 61, 60, 33};

        System.out.println(Arrays.toString(array));
        //bubbleSort(array);
        insertionSort(array);
        System.out.println(Arrays.toString(array));
    }

    public static void bubbleSort(int[] arr) {
        boolean sorted = true;
        while(sorted) {
            sorted = false;
            for(int i=0; i<arr.length-1; i++) {
                if (arr[i] > arr[i+1]) {
                    int aux = arr[i];
                    arr[i] = arr[i+1];
                    arr[i+1] = aux;
                    sorted = true;
                }
            }
        }
    }

    public static void insertionSort(int[] arr) {
        for (int i=1; i<arr.length; i++) {
            int currValue = arr[i];
            int idxLeft = i-1;
            while(idxLeft>=0 && arr[idxLeft]>currValue) {
                arr[idxLeft+1] = arr[idxLeft--];
            }
            arr[idxLeft+1] = currValue;
        }
    }

    public static void selectionSort(int[] arr) {
        int aux;
        int idxMin;
        for (int i=0; i<arr.length-1; i++) {
            idxMin = i; // indice del elemento con menor valor
            for (int j=i+1; j<arr.length; j++) {
                if (arr[j] < arr[idxMin]) {
                    idxMin = j;
                }
            }
            if (idxMin != i) {
                aux = arr[i];
                arr[i] = arr[idxMin];
                arr[idxMin] = aux;
            }
        }
    }
}
