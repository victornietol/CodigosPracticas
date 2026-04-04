package org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.facade;

import org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.facade.pieces.SmartPhone;

public class Main {
    public static void main(String[] args) {
        // construir objetos que utilizan varias piezas, oculta complejidad
        // de crear completamente el objeto con sus piezas, funcionamientos y ajustes.
        SmartPhone smartPhone1 = SmartPhoneFacade.startSmartPhone();
    }
}
