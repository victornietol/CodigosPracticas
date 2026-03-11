package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DetalleVentaDTO {
    private Long id;
    private String nameProd;
    private Integer unitsProd;
    private Double price;
    private Double subtotal;
}
