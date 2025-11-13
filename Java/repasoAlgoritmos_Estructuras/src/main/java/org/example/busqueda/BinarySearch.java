package org.example.busqueda;

import org.example.ordenamiento.MergeSort;
import org.example.ordenamiento.QuickSort;

import java.util.ArrayList;
import java.util.List;

public class BinarySearch {

    public static void main(String[] args) {
        List<Integer> list1 = new ArrayList<>();
        for (int i=0; i<50; i++) {
            int num = (int) (Math.random() * 100);
            list1.add(num);
        }

        QuickSort.sort(list1, 0, list1.size()-1);

        System.out.println(list1);

        int target = 20;
        System.out.println("Target= " + target);

        int ind = search(list1, target);

        if (ind >= 0) {
            System.out.println("Encontrado con indice: "+ ind);
        } else {
            System.out.println("No encontrado");
        }
    }

    public static int search(List<Integer> list, int target) {
        int start = 0;
        int end = list.size()-1;
        int mid;

        while(start <= end) {
            mid = (start + end) / 2;
            int curr = list.get(mid);

            if (curr == target) {
                return mid;
            }

            else if (curr > target) { // buscar izq
                end = mid-1;
            }

            else { // buscar der
                start = mid+1;
            }
        }

        return -1;
    }


}
