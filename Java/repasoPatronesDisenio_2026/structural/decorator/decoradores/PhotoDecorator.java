package org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.decorator.decoradores;

import org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.decorator.Photo;

public abstract class PhotoDecorator extends Photo {

    protected  Photo photo; // Podria ser una DigitalPhoto o un PhotoDecorator (otro decorador) porque ambos extienden de photo

    protected PhotoDecorator(Photo photo) {
        super();
        this.photo = photo;
    }
}
