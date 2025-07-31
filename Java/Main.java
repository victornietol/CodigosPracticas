package org.example.repasoAlgoritmos;

import java.util.ArrayList;
import java.util.Random;

public class Main {
    public static void main(String[] args) {
        ArrayList<Integer> list;

        list = Main.randomList(20, 1,200);
        System.out.println("---- Lista sin ordenar ----");
        System.out.println(list);

        //BubbleSort.sort(list);
        //InsertionSort.sort(list);
        //SelectionSort.order(list);
        //MergeSort.sort(list);
        QuickSort.sort(list, 0, list.size()-1);
        System.out.println("---- Lista ordenada ----");
        System.out.println(list);

        list.add(50);
        QuickSort.sort(list, 0, list.size()-1);
        //int found = LinearSearch.search(list, 50);
        int found = BinarySearch.search(list, 50);
        System.out.println("--- Resultado busqueda ---");
        System.out.println(list);
        System.out.println(found);
    }

    public static ArrayList<Integer> randomList(int size, int minLimint, int maxLimit) {
        ArrayList<Integer> list = new ArrayList<>();
        Random rand = new Random();
        for(int i=0; i<size; i++) {
            int randomNumeber = rand.nextInt(maxLimit-minLimint+1) +minLimint;
            list.add(randomNumeber);
        }
        return list;
    }
}
