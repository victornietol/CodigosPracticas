package org.example.estructurasDatos.ejercicios;

import java.util.Arrays;
import java.util.List;
import java.util.stream.IntStream;

public class ProgramacionFuncional {
    /**
     * Ejercicio consiste en un arreglo de 100 elementos del 1 al 100 del tipo int, utilizando
     * api stream se pide eliminar los divisibles en 10, luego convertir los elementos restantes
     * del flujo en tipo double y dividirlos en 2, para finalmente devolver la suma total de
     * todos ellos usando el operador terminal reduce. El resultado debería ser 2250.0
     *
     * @param args
     */
    public static void main(String[] args) {

        // opcion 1
        double res = IntStream.rangeClosed(1,100)
                .filter(e -> e%10 != 0)
                .mapToDouble(value -> (double) value/2)
                .reduce(0.0, (a,b) -> a+b); // es lo mismo que .reduce(0.0, Double::sum)

        // otra forma menos limpia
        int[] array = IntStream.rangeClosed(1,100).toArray();
        double res1 = Arrays.stream(array)
                .filter(e -> e%10 != 0)
                        .asDoubleStream()
                                .map(e -> e/2.0)
                                        .reduce(0.0, Double::sum);

        System.out.println("resultdo="+res);
    }
}
