package com.example.SpringBoot_MySQL_UUID_prueba.service;

import com.example.SpringBoot_MySQL_UUID_prueba.dto.UsuarioDTO;
import com.example.SpringBoot_MySQL_UUID_prueba.exceptions.ResourceNotFoundException;
import com.example.SpringBoot_MySQL_UUID_prueba.exceptions.UsernameAlreadyExistsException;
import com.example.SpringBoot_MySQL_UUID_prueba.model.UsuarioModel;
import com.example.SpringBoot_MySQL_UUID_prueba.repository.UsuarioRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
        if (repository.existsByUsername(usuarioDTO.getUsername())) {
            throw new UsernameAlreadyExistsException("Username ya existente: " + usuarioDTO.getUsername());
        }

        UsuarioModel usuario = UsuarioModel.builder()
                .username(usuarioDTO.getUsername())
                .build();
        return repository.save(usuario);
    }

    @Override
    @Transactional
    public void deleteByUsername(String username) {
        if (!repository.existsByUsername(username)) {
            throw new ResourceNotFoundException("Recurso no encontrado para eliminacion por USERNAME.");
        }
        repository.deleteByUsername(username);
    }

    @Override
    @Transactional
    public void deleteByUuid(UUID uuid) {
        if (!repository.existsById(uuid)) {
            throw new ResourceNotFoundException("Recurso no encontrado para eliminacion por UUID.");
        }
        repository.deleteById(uuid);
    }

}
