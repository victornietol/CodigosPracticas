package org.example.patronesDiseno.Strategy;

// Cada clase de comportamiento debe implementar la interfaz
public class BikeStrategy implements TransportStrategy {

    @Override
    public void transport() {
        System.out.println("Viajando en bici.");
        // logica del caso
    }
}

