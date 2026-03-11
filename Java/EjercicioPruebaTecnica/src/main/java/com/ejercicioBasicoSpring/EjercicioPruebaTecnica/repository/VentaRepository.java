package com.ejercicioBasicoSpring.EjercicioPruebaTecnica.repository;

import com.ejercicioBasicoSpring.EjercicioPruebaTecnica.model.Venta;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VentaRepository extends JpaRepository<Venta, Long> {
}
