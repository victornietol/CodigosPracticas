package com.example.spring_patrones_disenio.structural.facade;

import com.example.spring_patrones_disenio.structural.facade.pieces.*;

import java.util.Arrays;
import java.util.List;

public class SmartPhoneFacade {

    public static SmartPhone startSmartPhone() {

        // ensambla smartphone y lo enciende
        Battery battery = new Battery();

        CPU cpu = new CPU();

        Screen screen = new Screen();

        Sensor gps = new GPSSensor();

        Sensor nfc = new NFCSensor();
        List<Sensor> sensors = Arrays.asList(gps, nfc);

        SmartPhone oneplus = new SmartPhone(battery, cpu, screen, sensors);

        oneplus.start();

        for(Sensor sensor: oneplus.getSensors()) {
            sensor.start();
        }

        return oneplus;
    }
}
