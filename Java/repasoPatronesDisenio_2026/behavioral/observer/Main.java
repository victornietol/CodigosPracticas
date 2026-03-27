package org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer;

import org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer.device.Computer;
import org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer.device.Smartphone;
import org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer.device.WeatherType;

public class Main {
    public static void main(String[] args) {
        // clase principal, la que cambia el estado y que los observers quieren seguir
        Weather weather = new Weather();

        // se crean observadores para que puedan sre notificados
        Computer computer = new Computer();
        weather.addObserver(computer);
        weather.addObserver(new Smartphone());

        weather.changeWeather(WeatherType.CLOUDY);
        weather.changeWeather(WeatherType.RAINY);
        weather.changeWeather(WeatherType.SUNNY);

        weather.removeOberver(computer);
        weather.changeWeather(WeatherType.CLOUDY);
    }
}
