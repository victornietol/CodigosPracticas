package org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.facade.pieces;

import java.util.List;

public class SmartPhone {

    private Baterry baterry;
    private CPU cpu;
    private Screen screen;
    private List<Sensor> sensors;

    public SmartPhone(Baterry baterry, CPU cpu, Screen screen, List<Sensor> sensors) {
        this.baterry = baterry;
        this.cpu = cpu;
        this.screen = screen;
        this.sensors = sensors;
    }

    public void start() {
        System.out.println("SmartPhone encendido.");
    }

    public List<Sensor> getSensors() {
        return sensors;
    }
}
