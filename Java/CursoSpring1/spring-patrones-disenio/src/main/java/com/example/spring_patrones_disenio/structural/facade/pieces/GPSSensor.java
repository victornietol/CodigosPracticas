package com.example.spring_patrones_disenio.structural.facade.pieces;

public class GPSSensor implements Sensor {

    @Override
    public void start() {
        System.out.println("GPS Encendido.");
    }
}
