package org.example;

public class TorresHanoi {

    static int MOVS = 0;

    static void resolver(int nDiscos, String torreInicio, String torreFinal, String torrePivote) {


        if (nDiscos==1) {
            MOVS++;
            System.out.println(MOVS + ": Mover disco 1 de " + torreInicio + " a " + torreFinal);
        }

        else {
            resolver(nDiscos-1, torreInicio, torrePivote, torreFinal);
            MOVS ++;
            System.out.println(MOVS + ": Mover disco " + nDiscos + " de " + torreInicio + " a " + torreFinal);
            resolver(nDiscos-1, torrePivote, torreFinal, torreInicio);
        }
    }
}
