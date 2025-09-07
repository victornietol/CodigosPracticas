package com.example.spring_patrones_disenio.structural.facade;

import com.example.spring_patrones_disenio.structural.facade.pieces.SmartPhone;

public class Main {

    public static void main(String[] args) {

        // Construir objetos que utilizan varias piezas, oculta la complejidad de
        // crear completamente el objeto SmartPhone con sus piezas, funcionamientos, ajustes
        SmartPhone oneplus = SmartPhoneFacade.startSmartPhone();
    }
}
