package com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.processor;

import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.AuthenticationProcessor;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.AuthenticationProvider;
import com.example.spring_patrones_disenio.behavioral.chainOfResponsibility.provider.CSRFAuthProvider;

public class CSRFAuthenticationProcessor extends AuthenticationProcessor {

    public CSRFAuthenticationProcessor(AuthenticationProcessor next) {
        super(next);
    }

    @Override
    public boolean isAuthorized(AuthenticationProvider provider) {

        // Código propio
        if(provider instanceof CSRFAuthProvider)
            return true;

        // Sig proceso
        return next.isAuthorized(provider);
    }
}
