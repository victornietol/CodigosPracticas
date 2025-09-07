package com.example.spring_patrones_disenio.behavioral.observer;

public class SmartPhone implements WeatherObserver {

    @Override
    public void update(WeatherType type) {
        System.out.println("Smatphone ha sido actualzado del cambio de clima: "+type);
    }
}
