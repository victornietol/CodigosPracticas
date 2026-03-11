package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.repository;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Sucursal;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SucursalRepository extends JpaRepository<Sucursal, Long> {
}
