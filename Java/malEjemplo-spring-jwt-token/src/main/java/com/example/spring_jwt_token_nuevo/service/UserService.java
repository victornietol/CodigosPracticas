package com.example.spring_jwt_token_nuevo.service;


import com.example.spring_jwt_token_nuevo.domain.UserModel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

public interface UserService {

    List<UserModel> list();

    UserModel findByUsername(String username);

    HashMap<String, Object> create(UserModel user);

    boolean delete(String username);
}
