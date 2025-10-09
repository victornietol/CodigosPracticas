package com.example.RepasoSpringOlimpiadas.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Onu {

    @Id
    private String pais;
    private String continente;

    public Onu() {
    }

    public Onu(String pais, String continente) {
        this.pais = pais;
        this.continente = continente;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getContinente() {
        return continente;
    }

    public void setContinente(String continente) {
        this.continente = continente;
    }
}
