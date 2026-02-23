package com.example.repasoSencillo_Spring.Entity;

import jakarta.persistence.*;

import java.time.Year;

@Entity
@Table(name="libro")
public class LibroEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String titulo;
    private Year anio_publicacion;
    private Integer no_paginas;
    private String edicion;
    private Integer id_editorial;
    private Integer activo;

    public LibroEntity() {
    }

    public LibroEntity(Long id, String titulo, Year anio_publicacion, Integer no_paginas, String edicion, Integer id_editorial, Integer activo) {
        this.id = id;
        this.titulo = titulo;
        this.anio_publicacion = anio_publicacion;
        this.no_paginas = no_paginas;
        this.edicion = edicion;
        this.id_editorial = id_editorial;
        this.activo = activo;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public Year getAnio_publicacion() {
        return anio_publicacion;
    }

    public void setAnio_publicacion(Year anio_publicacion) {
        this.anio_publicacion = anio_publicacion;
    }

    public Integer getNo_paginas() {
        return no_paginas;
    }

    public void setNo_paginas(Integer no_paginas) {
        this.no_paginas = no_paginas;
    }

    public String getEdicion() {
        return edicion;
    }

    public void setEdicion(String edicion) {
        this.edicion = edicion;
    }

    public Integer getId_editorial() {
        return id_editorial;
    }

    public void setId_editorial(Integer id_editorial) {
        this.id_editorial = id_editorial;
    }

    public Integer getActivo() {
        return activo;
    }

    public void setActivo(Integer activo) {
        this.activo = activo;
    }

    @Override
    public String toString() {
        return "LibroEntity{" +
                "id=" + id +
                ", titulo='" + titulo + '\'' +
                ", anio_publicacion=" + anio_publicacion +
                ", no_paginas=" + no_paginas +
                ", edicion='" + edicion + '\'' +
                ", id_editorial=" + id_editorial +
                ", activo=" + activo +
                '}';
    }
}
