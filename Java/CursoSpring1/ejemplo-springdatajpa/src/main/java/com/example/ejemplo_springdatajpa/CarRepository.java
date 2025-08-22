package com.example.ejemplo_springdatajpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository // Spring crea la implementacion para esta interface
public interface CarRepository extends JpaRepository<CarModel, Long> { // Tipo de la clase (entidad) y tipo de la PK (tipo definido en CarModel)
}
