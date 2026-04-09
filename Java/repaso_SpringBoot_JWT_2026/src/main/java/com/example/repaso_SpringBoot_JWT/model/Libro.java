package com.example.repaso_SpringBoot_JWT.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Year;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Libro {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titulo;

    @Column(name = "anio_publicacion")
    private Year anioPublicacion;

    @Column(name = "no_paginas")
    private Integer noPaginas;

    private String edicion;

    @Column(name = "id_editorial")
    private Integer idEditorial;

    private Integer activo;
}
