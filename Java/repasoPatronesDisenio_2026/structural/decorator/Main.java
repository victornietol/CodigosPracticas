package org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.decorator;

import org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.decorator.decoradores.EffectRetro;
import org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.decorator.decoradores.EffectVintage;

public class Main {
    public static void main(String[] args) {

        // crear original
        Photo photo = new DigitalPhoto();

        // decoradores
        Photo photoRetro = new EffectRetro(photo);
        System.out.println(photoRetro.show());

        Photo photoVintage = new EffectVintage(photo);
        System.out.println(photoVintage.show());

        Photo photoVintageRetro = new EffectVintage(new EffectRetro(photo));
        System.out.println(photoVintageRetro.show());
        System.out.println(photoVintageRetro.cost());
    }
}
