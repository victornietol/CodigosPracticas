package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto;

import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VentaDTO {
    // datos de venta
    private Long id;
    private LocalDate date;
    private String status;

    // datos de sucursal
    private Long idSucursal;

    private List<DetalleVentaDTO> detail; // lista de detalles

    private Double total;
}
