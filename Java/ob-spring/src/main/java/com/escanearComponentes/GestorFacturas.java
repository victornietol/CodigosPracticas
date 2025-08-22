package com.escanearComponentes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class GestorFacturas {

    Calculator calculator;

    @Autowired // Indica que constructor utilizar
    public GestorFacturas(Calculator calculator) {
        System.out.println("Ejecutando constructor GestorFacturas");
        this.calculator = calculator;
    }
}
