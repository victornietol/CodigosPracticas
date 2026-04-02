package org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.decorator.decoradores;

import org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.decorator.Photo;

public class EffectRetro extends PhotoDecorator{

    public EffectRetro(Photo photo){
        super(photo);
    }

    @Override
    public String show() {
        // decorar photo
        this.photo.setBrightness(50);
        this.photo.setContrast(20);
        return this.photo.show() + " + Retro";
    }

    @Override
    public double cost() {
        return this.photo.cost() + 20;
    }
}
