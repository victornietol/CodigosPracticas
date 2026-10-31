package org.example.estructurasDatos.ejercicios;

import java.util.*;

public class TwoSum {
    public static void main(String[] args) {
        List<Integer> arr = List.of(2,7,11,15);
        List<Integer> sol = twoSum(arr, 9);
        System.out.println(sol);

        arr = List.of(3,2,4);
        sol = twoSum(arr, 6);
        System.out.println(sol);

        arr = List.of(3,3);
        sol = twoSum(arr, 6);
        System.out.println(sol);

        arr = List.of(3,3,20,4,8,14,1);
        sol = twoSum(arr, 17);
        System.out.println(sol);

        arr = List.of(3,0,3,20,4,8,14,1);
        sol = twoSum(arr, 1);
        System.out.println(sol);
    }

    public static List<Integer> twoSum(List<Integer> nums, int target) {
        HashMap<Integer, Integer> idxVisited = new HashMap<>(); // valor, indice
        List<Integer> solution = new ArrayList<>();
        int currValue, diff;

        for(int i=0; i<nums.size(); i++) {
            currValue = nums.get(i);
            diff = target-currValue;
            if (idxVisited.containsKey(diff)) {
                // se agregan los indices de las soluciones
                solution.add(idxVisited.get(diff));
                solution.add(i);
                break;
            } else {
                idxVisited.put(nums.get(i), i);
            }
        }

        return solution;
    }
}
