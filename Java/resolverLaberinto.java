package org.example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class resolverLaberinto {

    /**
     *  * = Punto vistado,
     *  X = Punto no disponible,
     *  O = Camino disponible,
     *  S = Salida,
     *  E = Entrada
     *
     * @param laberinto Corresponde al laberinto a resolver
     * @param camino Stack donde se guarda la solucion
     * @return Stack con la solucion del laberinto (puntos del camino)
     */
    public static List<List<Integer>> resolver(char[][] laberinto, List<List<Integer>> camino) {
        List<List<Integer>> visitarNuevo;
        List<Integer> nuevoPunto;

        List<Integer> puntoActual = new ArrayList<>(Arrays.asList(
                camino.getLast().get(0), // x
                camino.getLast().get(1)  // y
        ));

        if(laberinto[puntoActual.get(1)][puntoActual.get(0)] == 'S') {
            // Se encontro salida
            for(int i=0; i<laberinto.length; i++) {
                System.out.println(laberinto[i]);
            }
            return camino;

        } else if (laberinto[puntoActual.get(1)][puntoActual.get(0)] == 'O' || laberinto[puntoActual.get(1)][puntoActual.get(0)] == 'E') {
            // Es camino valido
            laberinto[puntoActual.get(1)][puntoActual.get(0)] = '*'; // Marcar como visitado
            // Intentar avanzar izquierda
            if(puntoActual.get(0)-1 >-1) {
                nuevoPunto = new ArrayList<>(Arrays.asList(
                        puntoActual.get(0)-1,
                        puntoActual.get(1)
                ));
                camino.add(nuevoPunto);
                visitarNuevo = resolver(laberinto, camino);
                if(visitarNuevo != null) {
                    return visitarNuevo; // Si es solucion
                }
                camino.removeLast(); // No se encontro solucion
            }
            // Intentar avanzar arriba
            if(puntoActual.get(1)-1 >-1) {
                nuevoPunto = new ArrayList<>(Arrays.asList(
                        puntoActual.get(0),
                        puntoActual.get(1)-1
                ));
                camino.add(nuevoPunto);
                visitarNuevo = resolver(laberinto, camino);
                if(visitarNuevo != null) {
                    return visitarNuevo; // Si es solucion
                }
                camino.removeLast(); // No se encontro solucion
            }
            // Intentar avanzar derecha
            if(puntoActual.get(0)+1 < laberinto[0].length) {
                nuevoPunto = new ArrayList<>(Arrays.asList(
                        puntoActual.get(0)+1,
                        puntoActual.get(1)
                ));
                camino.add(nuevoPunto);
                visitarNuevo = resolver(laberinto, camino);
                if(visitarNuevo != null) {
                    return visitarNuevo; // Si es solucion
                }
                camino.removeLast(); // No se encontro solucion
            }
            // Intentar avanzar abajo
            if(puntoActual.get(1)+1 < laberinto.length) {
                nuevoPunto = new ArrayList<>(Arrays.asList(
                        puntoActual.get(0),
                        puntoActual.get(1)+1
                ));
                camino.add(nuevoPunto);
                visitarNuevo = resolver(laberinto, camino);
                if(visitarNuevo != null) {
                    return visitarNuevo; // Si es solucion
                }
                camino.removeLast(); // No se encontro solucion
            }
            // No se puede avanzar a ningun punto
            return null;

        } else {
            // No es camino
            return null;
        }
    }
}
