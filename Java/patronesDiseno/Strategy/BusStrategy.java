package org.example.patronesDiseno.Strategy;

// Cada clase de comportamiento debe implementar la interfaz
public class BusStrategy implements TransportStrategy {

    @Override
    public void transport() {
        System.out.println("Viajando en bus.");
        // logica del caso
    }
}

