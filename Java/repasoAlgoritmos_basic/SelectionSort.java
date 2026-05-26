package org.example.estructurasDatos.ejercicios.repasoAlgoritmos;

import java.util.Arrays;
import java.util.List;

public class SelectionSort {
    public static void main(String[] args) {
        List<Integer> arr = Arrays.asList(75, 77, 40, 25, 65, 11, 37, 79, 85, 30, 40, 73, 87, 16, 19, 78, 56, 61, 60, 33);
        System.out.println("Lista desordenada: " + arr);
        SelectionSort.sort(arr);
        System.out.println("Lista selection sort: " + arr);
    }

    public static void sort(List<Integer> arr) {
        for (int i=0; i<arr.size()-1; i++) {
            int idxMinValue = i;
            for (int j=i+1; j<arr.size(); j++) {
                if (arr.get(j) < arr.get(idxMinValue)) {
                    idxMinValue = j;
                }
            }
            if (idxMinValue!=i) {
                int aux = arr.get(i);
                arr.set(i, arr.get(idxMinValue));
                arr.set(idxMinValue, aux);
            }
        }
    }
}
