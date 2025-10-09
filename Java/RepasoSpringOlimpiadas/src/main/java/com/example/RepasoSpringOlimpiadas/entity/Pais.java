package com.example.RepasoSpringOlimpiadas.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Pais {

    @Id
    private String pais;
    private Long atletas;
    private Integer oro;
    private Integer plata;
    private Integer bronce;
    private String continente;
    private Long habitantes;

    public Pais() {}

    public Pais(String pais, Long atletas, Integer oro, Integer plata, Integer bronce, String continente, Long habitantes) {
        this.pais = pais;
        this.atletas = atletas;
        this.oro = oro;
        this.plata = plata;
        this.bronce = bronce;
        this.continente = continente;
        this.habitantes = habitantes;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public Long getAtletas() {
        return atletas;
    }

    public void setAtletas(Long atletas) {
        this.atletas = atletas;
    }

    public Integer getOro() {
        return oro;
    }

    public void setOro(Integer oro) {
        this.oro = oro;
    }

    public Integer getPlata() {
        return plata;
    }

    public void setPlata(Integer plata) {
        this.plata = plata;
    }

    public Integer getBronce() {
        return bronce;
    }

    public void setBronce(Integer bronce) {
        this.bronce = bronce;
    }

    public String getContinente() {
        return continente;
    }

    public void setContinente(String continente) {
        this.continente = continente;
    }

    public Long getHabitantes() {
        return habitantes;
    }

    public void setHabitantes(Long habitantes) {
        this.habitantes = habitantes;
    }
}
