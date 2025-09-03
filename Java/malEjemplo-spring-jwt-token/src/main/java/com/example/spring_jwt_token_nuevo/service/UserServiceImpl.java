package com.example.spring_jwt_token_nuevo.service;

import com.example.spring_jwt_token_nuevo.domain.UserModel;
import com.example.spring_jwt_token_nuevo.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.management.ObjectName;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public List<UserModel> list() {
        return userRepository.findAll();
    }

    @Override
    public UserModel findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    /**
     * Devuelve un Hashmap con true o false dependiendo de si se creo el objeto, en caso de crearse se devuelve el objeto
     * @param user
     * @return
     */
    @Override
    public HashMap<String, Object> create(UserModel user) {
        HashMap<String, Object> response = new HashMap<>();
        if (user.getId()!=null) {
            response.put("saved", false);
            response.put("error", "Se ingreso valor del campo Id");
        } else {
            String passwHashed = passwordEncoder.encode(user.getPassword());
            user.setPassword(passwHashed);
            UserModel userSaved = userRepository.save(user);
            response.put("saved", true);
            response.put("user", userSaved);
        }
        return response;
    }

    @Override
    public boolean delete(String username) {
        if (!userRepository.existsByUsername(username))
            return false;

        userRepository.deleteByUsername(username);
        return true;
    }
}
