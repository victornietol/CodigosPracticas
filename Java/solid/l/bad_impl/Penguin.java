package org.example.solid.l.bad_impl;

public class Penguin extends Bird{
    @Override
    public void fly() {
        throw new UnsupportedOperationException("Penguins can´t fly");
    }
}
