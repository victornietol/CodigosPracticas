package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.exception;

public class NotFoundException extends RuntimeException{

    public NotFoundException(String msj) {
        super(msj);
    }
}
