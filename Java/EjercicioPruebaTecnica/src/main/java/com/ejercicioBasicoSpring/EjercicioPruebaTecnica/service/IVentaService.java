package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.service;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.VentaDTO;

import java.util.List;

public interface IVentaService {
    List<VentaDTO> getVentas(VentaDTO ventaDTO);
    VentaDTO createVenta(VentaDTO ventaDTO);
    VentaDTO updateVenta(Long id, VentaDTO ventaDTO);
    void deleteVenta(Long id);
}
