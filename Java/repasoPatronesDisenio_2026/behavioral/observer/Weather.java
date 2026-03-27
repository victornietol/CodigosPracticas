package org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer;

import org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer.device.WeatherType;

import java.util.ArrayList;
import java.util.List;

/**
 * Clase Weather que notifica del cambio de tiempo a los observadores
 */
public class Weather {
    private WeatherType currentWeather;
    private List<WeatherObserver> observers;

    public Weather() {
        this.observers = new ArrayList<>();
    }

    public void addObserver(WeatherObserver obs) {
        this.observers.add(obs);
        System.out.println("Observer agregado");
    }

    public void removeOberver(WeatherObserver obs) {
        this.observers.remove(obs);
        System.out.println("Observer eliminado");
    }

    // cambia el tiempo y ejecuta la notificacion
    void changeWeather(WeatherType currentWeather) {
        this.currentWeather = currentWeather;
        this.notifyObservers();
    }

    private void notifyObservers() {
//        for(WeatherObserver observer: this.observers) {
//            observer.update(this.currentWeather);
//        }
        this.observers.forEach(obs -> obs.update(this.currentWeather));
    }
}
