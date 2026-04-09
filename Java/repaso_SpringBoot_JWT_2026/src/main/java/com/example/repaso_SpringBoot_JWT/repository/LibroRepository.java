package com.example.repaso_SpringBoot_JWT.repository;

import com.example.repaso_SpringBoot_JWT.model.Libro;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LibroRepository extends JpaRepository<Libro, Long> {
}
