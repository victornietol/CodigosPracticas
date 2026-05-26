package org.example.estructurasDatos.ejercicios.repasoAlgoritmos;

import java.util.Arrays;
import java.util.List;

public class InsertionSort {
    public static void main(String[] args) {
        List<Integer> arr = Arrays.asList(75, 77, 40, 25, 65, 11, 37, 79, 85, 30, 40, 73, 87, 16, 19, 78, 56, 61, 60, 33);
        System.out.println("Lista desordenada: " + arr);
        InsertionSort.sort(arr);
        System.out.println("Lista insertion sort: " + arr);
    }

    public static void sort(List<Integer> arr) {
        for(int i=1; i<arr.size(); i++) {
            int currValue = arr.get(i);
            int idx_left = i-1;
            while (idx_left>=0 && arr.get(idx_left)>currValue) {
                arr.set(idx_left+1, arr.get(idx_left));
                --idx_left;
            }
            arr.set(idx_left+1, currValue);
        }
    }
}
