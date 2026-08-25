package com.example.SpringBoot_MySQL_UUID_prueba.service;

import com.example.SpringBoot_MySQL_UUID_prueba.dto.UsuarioDTO;
import com.example.SpringBoot_MySQL_UUID_prueba.exceptions.ResourceNotFoundException;
import com.example.SpringBoot_MySQL_UUID_prueba.model.UsuarioModel;
import com.example.SpringBoot_MySQL_UUID_prueba.repository.UsuarioRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

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
    public UsuarioModel findById(UUID uuid) {
        return repository.findById(uuid)
                .orElseThrow(() -> new ResourceNotFoundException("Recurso no encontrado por ID."));
    }

    @Override
    public UsuarioModel findByUsername(String username) {
        return repository.findByUsername(username)
                .orElseThrow(() -> new ResourceNotFoundException("Recurso no encontrado por USERNAME."));
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
                .orElseThrow(() -> new ResourceNotFoundException("Recurso no encontrado para eliminacion por USERNAME."));
        repository.delete(usuarioModel);
    }

    @Override
    public void deleteByUuid(UUID uuid) {
        UsuarioModel usuarioModel = repository.findById(uuid)
                .orElseThrow(() -> new ResourceNotFoundException("Recurso no encontrado para eliminacion por UUID."));
        repository.delete(usuarioModel);
    }
}
