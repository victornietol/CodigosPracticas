package org.example.repasoAlgoritmos;

import java.util.ArrayList;
import java.util.Random;

public class Main {
    public static void main(String[] args) {
        ArrayList<Integer> list;

        list = Main.randomList(20, 1,200);
        System.out.println("---- Lista sin ordenar ----");
        System.out.println(list);

        BubbleSort.sort(list);
        System.out.println("---- Lista ordenada ----");
        System.out.println(list);
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
