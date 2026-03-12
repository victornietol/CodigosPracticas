package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Venta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDate date;
    private String status;
    private Double total;

    @ManyToOne // define la relacion
    private Sucursal sucursal;

    @OneToMany(mappedBy = "venta", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER) // atributo perteneciente a con quien hace relacion
    private List<DetalleVenta> detail = new ArrayList<>();
}
