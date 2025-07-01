package org.example.patronesDiseno.Strategy;

// Cada clase de comportamiento debe implementar la interfaz
public class CarStrategy implements TransportStrategy {

    @Override
    public void transport() {
        System.out.println("Conduciendo en coche.");
        // logica del caso
    }
}
