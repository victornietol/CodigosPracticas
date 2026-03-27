package org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer;

import org.example.estructurasDatos.repasoPatronesDisenio_2026.behavioral.observer.device.WeatherType;

public interface WeatherObserver {
    /**
     * Actualiza el estado de observador con la nueva informacion notificada
     */
    void update(WeatherType type);
}
