package com.example.spring_patrones_disenio.behavioral.observer;

public class Computer implements WeatherObserver{

    @Override
    public void update(WeatherType type) {
        System.out.println("Computer ha sido actualzado del cambio de clima: "+type);
    }
}
