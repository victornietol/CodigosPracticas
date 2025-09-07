package com.example.spring_patrones_disenio.structural.decorator.decoradores;

import com.example.spring_patrones_disenio.structural.decorator.Photo;

public abstract class PhotoDecorator extends Photo {

    protected Photo photo; // Podria ser una DigitalPhoto o un PhotoDecorator (otro decorador) porque ambos extienden de photo

    protected PhotoDecorator(Photo photo){
        super();
        this.photo = photo;
    }
}
