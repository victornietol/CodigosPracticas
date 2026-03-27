package org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer.device;

import org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer.WeatherObserver;

import java.sql.SQLOutput;

public class Computer implements WeatherObserver {

    @Override
    public void update(WeatherType type) {
        System.out.println("Computer ha sido actualizado del cambio de clima: " + type);
    }
}
