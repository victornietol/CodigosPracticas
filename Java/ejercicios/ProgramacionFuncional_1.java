package org.example;

import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

public class ProgramacionFuncional_1 {
    public static void main(String[] args) {
        List<Integer> num = List.of(1,2,3,4,5,6);

        // EJEMPLO 1
        List<Integer> num2 = num.stream()
                .filter(n -> n%2==0)
                .map(n -> n*n)
                .toList();
        System.out.println(num2);


        // EJEMPLO 2
        // definir la funcion usando expresion lambda
        Function<Integer, Integer> duplicate = x -> x*2;

        List<Integer> num3 = num.stream()
                .map(duplicate)// es como hacer int res = duplicate.apply(1);  aplicando cada valor de entrada de "num"
                .toList();
        System.out.println(num3);
    }
}
