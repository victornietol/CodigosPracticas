package org.example.estructurasDatos.ejercicios;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class MergeSort {
    public static void main(String[] args) {
        Random rand = new Random();
        List<Integer> list = new ArrayList<>();
        int max = 50;
        int min = 1;

        for(int i=0; i<20; i++) {
            int num = rand.nextInt(max-min+1) +min;
            list.add(num);
        }

        System.out.println("Lista desordenada:\n" + list);
        list = sort(list);
        System.out.println("Lista ordenada:\n" + list);
    }

    public static List<Integer> sort(List<Integer> list) {
        List<List<Integer>> sublist; // asignacion de indices: 0 = izq, 1 = der
        if(list.size() > 1) {
            sublist = split(list);
            sublist.set(0, sort(sublist.get(0))); // izq
            sublist.set(1, sort(sublist.get(1))); // der
            return merge(sublist.get(0), sublist.get(1));
        } else {
            return list;
        }
    }

    private static List<List<Integer>> split(List<Integer> list) {
        int mid = list.size()/2;
        return Arrays.asList(list.subList(0,mid), list.subList(mid,list.size())); // izq, der
    }

    private static List<Integer> merge(List<Integer> left, List<Integer> right) {
        int i=0, j=0;
        List<Integer> newList = new ArrayList<>();

        while (i<left.size() && j<right.size()) {
            if (left.get(i) <= right.get(j)) {
                newList.add(left.get(i++));
            } else {
                newList.add(right.get(j++));
            }
        }

        while (i<left.size()) {
            newList.add(left.get(i++));
        }

        while (j<right.size()) {
            newList.add(right.get(j++));
        }

        return newList;
    }
}
