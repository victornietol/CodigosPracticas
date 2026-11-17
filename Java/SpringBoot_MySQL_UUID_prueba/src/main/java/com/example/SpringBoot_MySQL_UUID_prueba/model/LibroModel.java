package com.example.SpringBoot_MySQL_UUID_prueba.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.Year;
import java.util.UUID;

@Entity(name = "libro")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class LibroModel {

    @Id @GeneratedValue(strategy = GenerationType.UUID)
    private UUID uuid;

    private String titulo;
    private String autor;
    private String editorial;
    @Column(name = "anio_publicacion") private Year anioPublicacion;
}
