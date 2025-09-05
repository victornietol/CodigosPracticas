package com.example.spring_patrones_disenio.structural.facade.pieces;

import java.util.List;

public class SmartPhone {

    private Battery battery;
    private CPU cpu;
    private Screen screen;
    private List<Sensor> sensors;

    public SmartPhone(Battery battery, CPU cpu, Screen screen, List<Sensor> sensors) {
        this.battery = battery;
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
