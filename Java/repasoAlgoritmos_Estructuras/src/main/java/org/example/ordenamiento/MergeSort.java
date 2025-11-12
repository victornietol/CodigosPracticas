package org.example.ordenamiento;

import java.util.ArrayList;
import java.util.List;

public class MergeSort {
    /*
    complejidad = O(n log n)
     */

    public static void main(String[] args) {
        List<Integer> list1 = new ArrayList<>();
        for (int i=0; i<20; i++) {
            int num = (int) (Math.random() * 100);
            list1.add(num);
        }

        System.out.println(list1);

        sort(list1);

        System.out.println(list1);
    }

    public static void sort(List<Integer> list) {
        int mid;

        if (list.size()>1) {
            mid = list.size()/2;
            List<Integer> left = new ArrayList<>(list.subList(0, mid));
            List<Integer> right = new ArrayList<>(list.subList(mid, list.size()));

            sort(left);
            sort(right);

            merge(list, left, right);
        }
    }

    private static void merge(List<Integer> list, List<Integer> left, List<Integer> right) {
        int i = 0, j = 0, k = 0;

        while(i<left.size() && j<right.size()) {
            if(left.get(i) < right.get(j)) {
                list.set(k, left.get(i++));
            } else {
                list.set(k, right.get(j++));
            }
            k++;
        }

        while(i<left.size()) {
            list.set(k++, left.get(i++));
        }

        while(j<right.size()) {
            list.set(k++, right.get(j++));
        }
    }
}
