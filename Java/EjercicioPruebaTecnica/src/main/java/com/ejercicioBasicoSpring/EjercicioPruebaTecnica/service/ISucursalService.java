package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.service;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.dto.SucursalDTO;
import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Sucursal;

import java.util.List;

public interface ISucursalService {
    List<SucursalDTO> getSucursales();
    SucursalDTO createSucursal(SucursalDTO sucursalDTO);
    SucursalDTO updateSucursal(Long id, SucursalDTO sucursalDTO);
    void deleteSucursal(Long id);
}
