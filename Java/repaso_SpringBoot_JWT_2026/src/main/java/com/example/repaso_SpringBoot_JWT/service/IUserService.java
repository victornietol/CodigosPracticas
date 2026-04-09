package com.example.repaso_SpringBoot_JWT.service;

import com.example.repaso_SpringBoot_JWT.model.User;

public interface IUserService {
    public User findByUsername(String username);
    public User create(User user);
}
