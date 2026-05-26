package org.example.estructurasDatos.ejercicios.repasoAlgoritmos;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MergeSort {
    public static void main(String[] args) {
        List<Integer> arr = Arrays.asList(75, 77, 40, 25, 65, 11, 37, 79, 85, 30, 40, 73, 87, 16, 19, 78, 56, 61, 60, 33);
        System.out.println("Lista desordenada: " + arr);
        List<Integer> sorted = MergeSort.sort(arr);
        System.out.println("Lista merge sort: " + sorted);
    }

    public static List<Integer> sort(List<Integer> arr) {
        if (arr.size()>1) {
            List<List<Integer>> subsArrs = MergeSort.split(arr);
            List<Integer> left = MergeSort.sort(subsArrs.get(0));
            List<Integer> right = MergeSort.sort(subsArrs.get(1));
            return MergeSort.merge(left, right);
        } else {
            return arr;
        }
    }

    private static List<List<Integer>> split(List<Integer> arr) {
        int mid = arr.size()/2;
        List<Integer> left = arr.subList(0, mid);
        List<Integer> right = arr.subList(mid, arr.size());
        return Arrays.asList(left, right);
    }

    private static List<Integer> merge(List<Integer> left, List<Integer> right) {
        int i = 0;
        int j = 0;
        List<Integer> newArr = new ArrayList<>();

        while (i<left.size() && j<right.size()) {
            if (left.get(i) <= right.get(j)) {
                newArr.add(left.get(i++));
            } else {
                newArr.add(right.get(j++));
            }
        }

        while (i<left.size()) {
            newArr.add(left.get(i++));
        }

        while (j<right.size()) {
            newArr.add(right.get(j++));
        }

        return newArr;
    }
}
