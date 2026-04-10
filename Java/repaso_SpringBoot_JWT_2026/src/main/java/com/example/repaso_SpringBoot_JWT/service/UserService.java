package com.example.repaso_SpringBoot_JWT.service;

import com.example.repaso_SpringBoot_JWT.exceptions.ResourceNotFoundException;
import com.example.repaso_SpringBoot_JWT.model.User;
import com.example.repaso_SpringBoot_JWT.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class UserService implements IUserService{

    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

    @Override
    public User findByUsername(String username) {
        return repository.findByUsername(username)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario incorrecto"));
    }

    @Override
    public User create(User user) {
        user.setActive(true);
        return repository.save(user);
    }
}
