package com.escanearComponentes;

import org.springframework.stereotype.Component;

@Component // Indica que se va a escanear como un bean
public class Calculator {

    public Calculator() {
        System.out.println("Prueba de constructor Calculator");
    }

    public String ejemplo(){
        return "Prueba de bean calculator";
    }
}
