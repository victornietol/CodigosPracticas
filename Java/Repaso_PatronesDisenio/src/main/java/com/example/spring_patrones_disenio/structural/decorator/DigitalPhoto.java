package com.example.spring_patrones_disenio.structural.decorator;

public class DigitalPhoto extends Photo{

    @Override
    public String show() {
        return "Normal photo without edit";
    }

    @Override
    public double cost() {
        return 15;
    }
}
