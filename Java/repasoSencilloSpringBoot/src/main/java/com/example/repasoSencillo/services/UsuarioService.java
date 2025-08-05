package com.example.repasoSencillo.services;

import com.example.repasoSencillo.models.UsuarioModel;
import com.example.repasoSencillo.repositories.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
public class UsuarioService {

    @Autowired
    UsuarioRepository usuarioRepository;

    // Metodos estandar
    public ArrayList<UsuarioModel> getUsuarios() {
        return (ArrayList<UsuarioModel>) usuarioRepository.findAll();
    }

    public UsuarioModel saveUsuario(UsuarioModel user) {
        return usuarioRepository.save(user);
    }

    public Optional<UsuarioModel> getById(Long id) {
        return usuarioRepository.findById(id);
    }

    public boolean deleteUsuario(Long id) {
        try{
            usuarioRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }


    //Metodos especificos o personalizados
    public ArrayList<UsuarioModel> getByUsername(String username) {
        return usuarioRepository.findByUsername(username);
    }
}
