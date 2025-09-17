package org.example.solid.o.bad_impl;

public class AreaCalculator {
    public double calculateArea(Object shape) {
        if(shape instanceof Rectangle) {
            // calculation for rectangle
        }
        if(shape instanceof Circle) {
            // calculation for circle
        }
        return 0.0;
    }
}
