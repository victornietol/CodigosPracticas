package com.example.Ejemplo_JWT.service;

import com.example.Ejemplo_JWT.entity.UserInfo;
import com.example.Ejemplo_JWT.repository.UserInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserInfoService implements UserDetailsService {

    @Autowired
    private UserInfoRepository repository;
    @Autowired
    private PasswordEncoder encoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // Buscar usuario por email y si lo encuentra lo convierte en userDetails (se utiliza email en lugar de username)
        Optional<UserInfo> userDetail = repository.findByEmail(username);
        return userDetail.map(UserInfoDetails::new)
                .orElseThrow(() -> new UsernameNotFoundException("Credenciales invalidas."));
    }

    public boolean addUser(UserInfo userInfo) {
        userInfo.setPassword(encoder.encode(userInfo.getPassword()));
        try {
            repository.save(userInfo);
            return true;
        } catch (Exception e) {
            System.out.println("Error al guardar usuario: service/UserInfoService.java  linea 33");
            return false;
        }
    }

    public List<UserInfo> getUsers() {
        return repository.findAll();
    }
}
