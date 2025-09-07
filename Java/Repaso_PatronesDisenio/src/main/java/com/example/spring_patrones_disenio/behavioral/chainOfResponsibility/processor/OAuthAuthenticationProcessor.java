package com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.processor;

import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.AuthenticationProcessor;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.AuthenticationProvider;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.provider.OAuthProvider;

public class OAuthAuthenticationProcessor extends AuthenticationProcessor {

    public OAuthAuthenticationProcessor(AuthenticationProcessor next) {
        super(next);
    }

    @Override
    public boolean isAuthorized(AuthenticationProvider provider) {

        // Logica de este processor, aqui termina en caso de que se acaben las
        // comprobaciones, de lo contrario, saltara al siguiente processor
        if(provider instanceof OAuthProvider) {
            return true;
        }

        // Llama al siguiente processor
        return next.isAuthorized(provider);
    }
}
