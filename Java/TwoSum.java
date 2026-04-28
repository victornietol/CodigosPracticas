package org.example;

import java.util.*;

public class TwoSum {
    public static void main(String[] args) {
        int[] array = {2, 7, 11, 15, -2, 9, 1, 8};
        int target = 9;

        Set<List<Integer>> res = twoSum1(array, target);
        System.out.println(res);

    }

    static Set<List<Integer>> twoSum1(int[] array, int target) {
        // ENCONTRAR PARES SIN REPETIR
        HashMap<Integer, Integer> revised = new HashMap<>();
        Set<List<Integer>> pairs = new HashSet<>();

        for (int i=0; i<array.length; i++) {
            int complement = target - array[i];
            if (revised.containsKey(complement)) {
                if (!pairs.contains(List.of(complement, array[i])) && !pairs.contains(List.of(array[i], complement))) {
                    pairs.add(List.of(complement, array[i]));
                }
            }
            revised.put(array[i], array[i]);
        }
        return pairs;
    }
}
