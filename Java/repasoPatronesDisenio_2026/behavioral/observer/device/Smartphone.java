package org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer.device;

import org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer.WeatherObserver;

public class Smartphone implements WeatherObserver {
    @Override
    public void update(WeatherType type) {
        System.out.println("Smartphone ha sido actualizado del cambio de clima: " + type);
    }
}
