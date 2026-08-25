package com.example.SpringBoot_MySQL_UUID_prueba.repository;

import com.example.SpringBoot_MySQL_UUID_prueba.model.UsuarioModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface UsuarioRepository extends JpaRepository<UsuarioModel, UUID> {
    Optional<UsuarioModel> findByUsername(String username);
    void deleteByUsername(String username);
    boolean existsByUsername(String username);
}
