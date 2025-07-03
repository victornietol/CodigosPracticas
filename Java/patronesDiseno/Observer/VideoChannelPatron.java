package org.example.patronesDiseno.Observer;

import java.util.ArrayList;

// Con patron de diseño los susbcriptores se notifican automaticamente al llamar al metodo correspondiente
public class VideoChannelPatron {
    private ArrayList<Subscriber> subscribers = new ArrayList<>();

    void subscribe(Subscriber subscriber) {
        this.subscribers.add(subscriber);
    }

    void unsubscribe(Subscriber subscriber) {
        // Logica para eliminar al subscriptor
    }

    void uploadVideo(String title) {
        System.out.println("Subiendo video");
        // Logica para subir video
        this.notify(title);
    }

    private void notify(String videoTitle) {
        this.subscribers.forEach( sub -> sub.update(videoTitle));
    }
}
