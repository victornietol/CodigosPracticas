package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SucursalDTO {
    private Long id;
    private String name;
    private String address;
}
