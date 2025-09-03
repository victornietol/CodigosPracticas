package com.example.spring_jwt_auth.service;

import com.example.spring_jwt_auth.model.UserInfo;
import com.example.spring_jwt_auth.repository.UserInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserInfoService implements UserDetailsService {

    private final UserInfoRepository repository;
    private final PasswordEncoder encoder;

    @Autowired
    public UserInfoService(UserInfoRepository repository, PasswordEncoder encoder) {
        this.repository = repository;
        this.encoder = encoder;
    }

    // cargar detalles de user por username (que en realidad es el email)
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<UserInfo> userInfo = repository.findByEmail(username);

        if(userInfo.isEmpty()) {
            throw  new UsernameNotFoundException("User not found with email: " + username);
        }

        // Convertir UserInfo a UserDetails (UserInfoDetails)
        UserInfo user = userInfo.get();
        return new User(
                user.getEmail(),
                user.getPassword(),
                // El tercer argunmento se implementa asi porque user.getRoles devuelve un String y se necesita un Collection
                Arrays.stream(user.getRoles().split(","))
                        .map(String::trim)
                        .map(SimpleGrantedAuthority::new)
                        .collect(Collectors.toList())
        );
    }

    public UserInfo addUser(UserInfo userInfo) {
        userInfo.setPassword(
                encoder.encode(userInfo.getPassword())
        );

        return repository.save(userInfo);
    }

}
