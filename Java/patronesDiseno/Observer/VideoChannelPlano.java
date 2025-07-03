package org.example.patronesDiseno.Observer;

import java.util.ArrayList;

public class VideoChannelPlano {
    private ArrayList<UserAccount> subscribers = new ArrayList<>();

    // Sin patron de diseño
    public void uploadVideo(String video) {
        // Logica de subir video ...
        // Despues se tendria que manejar aqui como enviar las notificaciones a cada suscriptor
        System.out.println("Video subido, pero sin notificaciones del sistema");
    }
}
