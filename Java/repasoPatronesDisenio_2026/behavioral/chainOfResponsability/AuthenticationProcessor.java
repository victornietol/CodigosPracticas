package org.example.estructurasDatos.repasoPatronesDisenio.behavioral.chainOfResponsability;

public abstract class AuthenticationProcessor {

    public AuthenticationProcessor next;

    public AuthenticationProcessor(AuthenticationProcessor next) {
        this.next = next;
    }

    public abstract boolean isAuthorized(AuthenticationProvider provider);
}
