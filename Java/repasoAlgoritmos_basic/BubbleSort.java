package org.example.estructurasDatos.ejercicios.repasoAlgoritmos;

import java.util.Arrays;
import java.util.List;

public class BubbleSort {
    public static void main(String[] args) {
        List<Integer> arr = Arrays.asList(75, 77, 40, 25, 65, 11, 37, 79, 85, 30, 40, 73, 87, 16, 19, 78, 56, 61, 60, 33);
        System.out.println("Lista desordenada: " + arr);
        BubbleSort.sort(arr);
        System.out.println("Lista bubble sort: " + arr);
    }

    public static void sort(List<Integer> arr) {
        boolean swapped = true;
        while(swapped) {
            swapped = false;
            for(int i=0; i<arr.size()-1; i++) {
                if (arr.get(i)>arr.get(i+1)) {
                    int aux = arr.get(i);
                    arr.set(i, arr.get(i+1));
                    arr.set(i+1, aux);
                    swapped = true;
                }
            }
        }
    }
}
