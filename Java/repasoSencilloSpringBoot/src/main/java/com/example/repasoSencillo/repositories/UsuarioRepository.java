package com.example.repasoSencillo.repositories;

import com.example.repasoSencillo.models.UsuarioModel;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface UsuarioRepository extends CrudRepository<UsuarioModel, Long> {
    // metodos para hacer distintas consultas especificas con ayuda de CrudRepository (especificos)
    public abstract ArrayList<UsuarioModel> findByUsername(String username); // Se debe seguir la convencion del nombre del metodo y agregarle el nombre del campo con el que va a interactuar

}
