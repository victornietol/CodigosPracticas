package com.example.spring_patrones_disenio.structural.proxy;

public class ProxyImage implements Image {

    private RealImage realImage;
    private String fileName;

    public ProxyImage(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public void show() {
        // El objeto realImage se crea solo la primera vez
        if(realImage==null) {
            this.realImage = new RealImage(fileName);
        }
        realImage.show();
    }
}
