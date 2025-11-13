package org.example.busqueda;

import org.example.ordenamiento.MergeSort;

import java.util.ArrayList;
import java.util.List;

public class LinearSearch {

    public static void main(String[] args) {
        List<Integer> list1 = new ArrayList<>();
        for (int i=0; i<50; i++) {
            int num = (int) (Math.random() * 100);
            list1.add(num);
        }

        MergeSort.sort(list1);

        System.out.println(list1);

        int target = 10;
        System.out.println("Target= " + target);

        int ind = search(list1, target);

        if (ind >= 0) {
            System.out.println("Encontrado con indice: "+ ind);
        } else {
            System.out.println("No encontrado");
        }
    }

    public static Integer search(List<Integer> list, int target) {
        /*
        Devuelve el indice si lo encuentra
         */
        for(int i=0; i<list.size(); i++) {
            if (list.get(i) == target) {
                return i;
            }
        }
        return -1;
    }
}
