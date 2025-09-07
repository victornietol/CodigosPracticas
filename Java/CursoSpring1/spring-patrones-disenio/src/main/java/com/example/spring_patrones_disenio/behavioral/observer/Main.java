package com.example.spring_patrones_disenio.behavioral.observer;

public class Main {
    public static void main(String[] args) {

        // 1.Clase principal, la que cambia el estado y que los observadores quieren seguir
        Weather aemet = new Weather();

        // 2.Se crean observadores para que puedan ser notificados
        WeatherObserver computer = new Computer();
        aemet.addObserver(computer);
        aemet.addObserver(new SmartPhone());

        aemet.changeWeather(WeatherType.CLOUDY);
        aemet.changeWeather(WeatherType.RAINY);
        aemet.changeWeather(WeatherType.SUNNY);

        aemet.removeObserver(computer);
        aemet.changeWeather(WeatherType.SUNNY);

    }
}
