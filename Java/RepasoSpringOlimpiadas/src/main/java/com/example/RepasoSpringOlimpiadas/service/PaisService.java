package com.example.RepasoSpringOlimpiadas.service;

import com.example.RepasoSpringOlimpiadas.entity.Pais;
import com.example.RepasoSpringOlimpiadas.repository.PaisRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PaisService {

    private final PaisRepository repository;

    public PaisService (PaisRepository repository) {
        this.repository = repository;
    }

    public List<Pais> getPaises() {
        return repository.findAll();
    }

    public Pais getById(String paisNombre) {
        Optional<Pais> paisOptional = repository.findById(paisNombre);
        return paisOptional.orElse(null);
    }

    public Pais save(Pais pais) {
        Optional<Pais> paisOptional = repository.findById(pais.getPais());
        if(paisOptional.isPresent()) { // ya existe el objeto
            return null;
        }
        return repository.save(pais);
    }

    public Pais update(Pais pais) {
        Optional<Pais> paisOptional = repository.findById(pais.getPais());
        if (paisOptional.isPresent()) {
            return repository.save(pais);
        } else { // No existe el objeto a actualizar
            return null;
        }
    }

    public Pais updatePartial(Pais pais) {
        Optional<Pais> paisOptional = repository.findById(pais.getPais());
        if (paisOptional.isPresent()) {
            Pais paisUpdate = paisOptional.get();
            if (pais.getAtletas()!=null)
                paisUpdate.setAtletas(pais.getAtletas());
            if (pais.getOro()!=null)
                paisUpdate.setOro(pais.getOro());
            if (pais.getPlata()!=null)
                paisUpdate.setPlata(pais.getPlata());
            if (pais.getBronce()!=null)
                paisUpdate.setBronce(pais.getBronce());
            if (pais.getContinente()!=null)
                paisUpdate.setContinente(pais.getContinente());
            if (pais.getHabitantes()!=null)
                paisUpdate.setHabitantes(pais.getHabitantes());
            return repository.save(paisUpdate);
        } else { // No existe el objeto a actualizar
            return null;
        }
    }

    public boolean deletePais(String nombrePais) {
        Optional<Pais> paisOptional = repository.findById(nombrePais);
        if (paisOptional.isPresent()) {
            repository.deleteById(nombrePais);
            return true;
        }
        return false;
    }
}
