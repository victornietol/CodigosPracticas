package org.example.patronesDiseno.Strategy;

// Sin Factory
public class Commuter {
    public void goToWork(String transportType) {
        // Sin patron de diseño se aplican muchos if
        if(transportType.equals("car")) {
            // Logica
            System.out.println("Coche sin patron");
        } else if(transportType.equals("bus")) {
            // logica
            System.out.println("Bus sin patron");
        } else if (transportType.equals("bike")) {
            // logica
            System.out.println("Bike sin patron");
        }
        // Sigue creciendo segun mas tipos
    }
}
