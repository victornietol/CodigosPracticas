package com.example.ejemplo_springdatajpa;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class CarModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Autoincrement
    private Long id;

    private String manufacturer;
    private String model;
    private Integer productionYear;

    public CarModel() {
    }

    public CarModel(Long id, String manufacturer, String model, Integer year) {
        this.id = id;
        this.manufacturer = manufacturer;
        this.model = model;
        this.productionYear = year;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public Integer getYear() {
        return productionYear;
    }

    public void setYear(Integer year) {
        this.productionYear = year;
    }

    @Override
    public String toString() {
        return "CarModel{" +
                "id=" + id +
                ", manufacturer='" + manufacturer + '\'' +
                ", model='" + model + '\'' +
                ", year=" + productionYear +
                '}';
    }
}
