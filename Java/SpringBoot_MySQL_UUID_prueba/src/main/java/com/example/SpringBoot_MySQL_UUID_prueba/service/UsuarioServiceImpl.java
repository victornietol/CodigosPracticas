package com.example.SpringBoot_MySQL_UUID_prueba.service;

import com.example.SpringBoot_MySQL_UUID_prueba.dto.UsuarioDTO;
import com.example.SpringBoot_MySQL_UUID_prueba.exceptions.ResourceNotFoundException;
import com.example.SpringBoot_MySQL_UUID_prueba.model.UsuarioModel;
import com.example.SpringBoot_MySQL_UUID_prueba.repository.UsuarioRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UsuarioServiceImpl implements IUsuarioService {

    private final UsuarioRepository repository;

    public UsuarioServiceImpl(UsuarioRepository repository) {
        this.repository = repository;
    }


    @Override
    public List<UsuarioModel> getAll() {
        return repository.findAll();
    }

    @Override
    public Optional<UsuarioModel> findByUsername(String username) {
        return repository.findByUsername(username);
    }

    @Override
    public UsuarioModel create(UsuarioDTO usuarioDTO) {
        UsuarioModel usuario = UsuarioModel.builder()
                .username(usuarioDTO.getUsername())
                .build();
        return repository.save(usuario);
    }

    @Override
    public void deleteByUsername(String username) {
        UsuarioModel usuarioModel = repository.findByUsername(username)
                .orElseThrow(() -> new ResourceNotFoundException("Recurso no encontrado para eliminacion."));
        repository.delete(usuarioModel);
    }
}
