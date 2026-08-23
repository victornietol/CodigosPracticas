package com.example.SpringBoot_MySQL_UUID_prueba.service;

import com.example.SpringBoot_MySQL_UUID_prueba.dto.UsuarioDTO;
import com.example.SpringBoot_MySQL_UUID_prueba.model.UsuarioModel;

import java.util.List;
import java.util.Optional;

public interface IUsuarioService {
    List<UsuarioModel> getAll();
    Optional<UsuarioModel> findByUsername(String username);
    UsuarioModel create(UsuarioDTO usuarioDTO);
    void deleteByUsername(String username);
}
