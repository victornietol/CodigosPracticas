package org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.facade;

import org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.facade.pieces.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SmartPhoneFacade {

    public static SmartPhone startSmartPhone() {
        // ensambla y lo enciende
        Baterry baterry = new Baterry();
        CPU cpu = new CPU();
        Screen screen = new Screen();
        Sensor gps = new GPSSensor();
        Sensor nfc = new NFCSensor();
        List<Sensor> sensors = Arrays.asList(gps, nfc);

        SmartPhone smartPhone1 = new SmartPhone(baterry, cpu, screen, sensors);

        smartPhone1.start();

        for (Sensor sensor: smartPhone1.getSensors()) {
            sensor.start();
        }

        return smartPhone1;
    }
}
