package org.example.patronesDiseno.Strategy;

public class BetterCommuter {
    private TransportStrategy strategy; // Interface para asiganar el comportamiento dependiendod el caso

    public void setStrategy(TransportStrategy strategy) {
        this.strategy = strategy;
    }

    public void goToWork() {
        if(this.strategy == null) {
            throw new RuntimeException("Transport strategy no asignado.");
        }
        this.strategy.transport(); // Usa el metodo segun la clase implementada
    }
}
