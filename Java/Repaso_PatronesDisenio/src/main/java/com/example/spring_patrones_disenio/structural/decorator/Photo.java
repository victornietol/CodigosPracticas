package com.example.spring_patrones_disenio.structural.decorator;

public abstract class Photo {

    private Integer brightness;
    private Integer contrast;
    private Integer saturation;
    private Integer blur;

    public abstract String show();

    public abstract double cost();

    public Integer getBrightness() {
        return brightness;
    }

    public void setBrightness(Integer brightness) {
        this.brightness = brightness;
    }

    public Integer getContrast() {
        return contrast;
    }

    public void setContrast(Integer contrast) {
        this.contrast = contrast;
    }

    public Integer getSaturation() {
        return saturation;
    }

    public void setSaturation(Integer saturation) {
        this.saturation = saturation;
    }

    public Integer getBlur() {
        return blur;
    }

    public void setBlur(Integer blur) {
        this.blur = blur;
    }

    @Override
    public String toString() {
        return "Photo{" +
                "brightness=" + brightness +
                ", contrast=" + contrast +
                ", saturation=" + saturation +
                ", blur=" + blur +
                '}';
    }
}
