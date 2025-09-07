package com.example.spring_patrones_disenio.structural.adapter;

public class TractorAdapter implements Movable {

    private Tractor tractor = new Tractor();

    // Adapta el comportamiento de la clase para poder ajustar
    // la funcionalidad que tiene por defecto a lo que se necesita,
    // en este caso, implementar speedUp debido a la interface Movable
    @Override
    public void speedUp(double quantity) {
        if(this.tractor.getSpeed()+quantity < 15) {
            this.tractor.changeMode(1);
        } else {
            this.tractor.changeMode(2);
        }
    }
}
