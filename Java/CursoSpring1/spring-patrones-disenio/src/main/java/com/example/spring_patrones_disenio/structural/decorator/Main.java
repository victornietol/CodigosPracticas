package com.example.spring_patrones_disenio.structural.decorator;

import com.example.spring_patrones_disenio.structural.decorator.decoradores.EffectRetro;
import com.example.spring_patrones_disenio.structural.decorator.decoradores.EffectVintage;

public class Main {
    public static void main(String[] args) {

        // Se crea un objeto original
        Photo selfie = new DigitalPhoto();

        // Se aplican decoradores
        Photo selfieRetro = new EffectRetro(selfie);
        System.out.println(selfieRetro.show());

        Photo selfieVintage = new EffectVintage(selfie);
        System.out.println(selfieVintage.show());

        Photo selfieVintageRetro = new EffectRetro(new EffectVintage(selfie));
        System.out.println(selfieVintageRetro.show());

    }
}
