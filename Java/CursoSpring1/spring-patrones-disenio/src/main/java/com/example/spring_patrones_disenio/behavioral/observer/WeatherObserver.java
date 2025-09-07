package com.example.spring_patrones_disenio.behavioral.observer;

/**
 * Representa un observador
 */
public interface WeatherObserver {
    /**
     * Actualiza el estado de observador con la nueva informacion notificada desde la clase que cambia
     * @param type
     */
    void update(WeatherType type);
}
