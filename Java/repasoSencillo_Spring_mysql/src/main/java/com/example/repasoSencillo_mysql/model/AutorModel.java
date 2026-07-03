package com.example.repasoSencillo_mysql.model;

import jakarta.persistence.*;
import lombok.*;

@Entity(name = "autor")
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@ToString
@Builder
public class AutorModel {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nombre;

    @Column(name = "apellido_p")
    private String apellidoP;

    @Column(name = "apellido_m")
    private String apellidoM;

    private Boolean activo;
}
