package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class DetalleVenta {
    /**
     * Cada DetalleVenta corresponde a un renglon de un ticket
     */

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ventaId")
    private Venta venta;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productoId")
    private Producto producto;
    private Integer unitsProd;
    private Double price;
}
