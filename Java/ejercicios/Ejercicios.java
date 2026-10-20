package org.example;


import java.util.ArrayList;
import java.util.List;

public class Ejercicios {
    public static void main(String[] args) {
        ArrayList<ArrayList<Integer>> tr = pascalTriangle(5);
        tr.forEach(System.out::println);
//        for (ArrayList<Integer> level : tr) {
//            System.out.println(level);
//        }
    }

    public static ArrayList<ArrayList<Integer>> pascalTriangle(int levels) {
        ArrayList<ArrayList<Integer>> triangle = new ArrayList<>();
        triangle.add(new ArrayList<>(List.of(1))); // primer nivel
        if (levels > 1) { // mas de 1 nivel
            for (int i=1; i<=levels-1; i++) {
                ArrayList<Integer> currSublevel = new ArrayList<>(List.of(1));
                ArrayList<Integer> prevSublevel = triangle.get(i-1);
                for(int j=0; j<triangle.get(i-1).size()-1; j++) {
                    currSublevel.add(prevSublevel.get(j) + prevSublevel.get(j+1));
                }
                currSublevel.add(1);
                triangle.add(currSublevel);
            }
        }

        return triangle;
    }
}
