package org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.processor;

import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.AuthenticationProcessor;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.AuthenticationProvider;
import org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability.provider.CSRFAuthProvider;

public class CSRFAuthenticationProcessor extends AuthenticationProcessor {

    public CSRFAuthenticationProcessor(AuthenticationProcessor next) {
        super(next);
    }

    @Override
    public boolean isAuthorized(AuthenticationProvider provider) {

        // codigo propio
        if(provider instanceof CSRFAuthProvider) {
            System.out.println("Es CSRFAuthProvider");
            return true;
        }

        // sig proceso
        return next.isAuthorized(provider);
    }
}
