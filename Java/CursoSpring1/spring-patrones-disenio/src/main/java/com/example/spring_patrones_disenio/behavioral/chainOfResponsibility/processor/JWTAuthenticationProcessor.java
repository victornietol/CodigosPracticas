package com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.processor;

import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.AuthenticationProcessor;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.AuthenticationProvider;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.provider.JWTAuthProvider;

public class JWTAuthenticationProcessor extends AuthenticationProcessor {

    public JWTAuthenticationProcessor(AuthenticationProcessor next) {
        super(next);
    }

    @Override
    public boolean isAuthorized(AuthenticationProvider provider) {

        if(provider instanceof JWTAuthProvider)
            return true;

        return next.isAuthorized(provider);
    }
}
