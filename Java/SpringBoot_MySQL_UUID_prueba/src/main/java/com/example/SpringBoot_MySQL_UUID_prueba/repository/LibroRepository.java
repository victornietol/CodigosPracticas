package com.example.SpringBoot_MySQL_UUID_prueba.repository;

import com.example.SpringBoot_MySQL_UUID_prueba.model.LibroModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface LibroRepository extends JpaRepository<LibroModel, UUID> {
    Optional<LibroModel> findByTitulo(String title);
    void deleteByTitulo(String title);
    boolean existsByTitulo(String title);
}
