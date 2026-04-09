package com.example.repaso_SpringBoot_JWT.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
public class Autor {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nombre;

    @Column(name = "apellido_p")
    private String apellidoP;

    @Column(name = "apellido_m")
    private String apellidoM;

    private Integer activo;

}
