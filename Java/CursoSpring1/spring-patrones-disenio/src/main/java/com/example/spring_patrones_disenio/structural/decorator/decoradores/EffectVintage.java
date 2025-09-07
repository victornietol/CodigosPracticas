package com.example.spring_patrones_disenio.structural.decorator.decoradores;

import com.example.spring_patrones_disenio.structural.decorator.Photo;

public class EffectVintage extends PhotoDecorator {

    public EffectVintage(Photo photo){
        super(photo);
    }

    @Override
    public String show() {
        // decorar photo
        this.photo.setBrightness(90);
        this.photo.setContrast(20);
        this.photo.setBlur(5);
        return this.photo.show() + " + Vintage";
    }

    @Override
    public double cost() {
        return this.photo.cost() + 15;
    }
}
