package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductoDTO {
    private Long id;
    private String name;
    private String category;
    private Double price;
    private Integer units;
}
