package com.example.SpringBoot_MySQL_UUID_prueba.repository;

import com.example.SpringBoot_MySQL_UUID_prueba.model.UsuarioModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface UsuarioRepository extends JpaRepository<UsuarioModel, UUID> {
}
