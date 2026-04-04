package org.example.estructurasDatos.repasoPatronesDisenio_2026.structural.proxy;

public class ProxyImage implements Image{

    private RealImage realImage;
    private String fileName;

    public ProxyImage(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public void show() {
        // el objeto realImage solo se crea la primera vez
        if(realImage==null) {
            this.realImage = new RealImage(fileName);
        }
        realImage.show();
    }
}
