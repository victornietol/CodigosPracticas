package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.mapper;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.DetalleVentaDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.ProductoDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.SucursalDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.VentaDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Producto;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Sucursal;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Venta;

import java.util.stream.Collectors;

public class Mapper {
    /**
     * Mapea de un objeto a otro
     */

    // Producto
    public static ProductoDTO toDTO(Producto p) {
        if (p == null) return null;

        return ProductoDTO.builder()
                .id(p.getId())
                .name(p.getName())
                .category(p.getCategory())
                .price(p.getPrice())
                .units(p.getUnits())
                .build();
    }

    // Sucursal
    public static SucursalDTO toDTO(Sucursal s) {
        if (s == null) return null;

        return SucursalDTO.builder()
                .id(s.getId())
                .name(s.getName())
                .address(s.getAddress())
                .build();
    }

    // Venta
    public static VentaDTO toDTO(Venta venta) {
        if (venta == null) return null;

        var detail = venta.getDetail().stream().map(det ->
                DetalleVentaDTO.builder()
                        .id(det.getProducto().getId())
                        .nameProd(det.getProducto().getName())
                        .unitsProd(det.getUnitsProd())
                        .price(det.getPrice())
                        .subtotal(det.getPrice() * det.getUnitsProd())
                        .build()
        ).collect(Collectors.toList());

        var total = detail.stream()
                .map(DetalleVentaDTO::getSubtotal)
                .reduce(0.0, Double::sum);

        return VentaDTO.builder()
                .id(venta.getId())
                .date(venta.getDate())
                .idSucursal(venta.getSucursal().getId())
                .status(venta.getStatus())
                .detail(detail)
                .total(total)
                .build();
    }
}
