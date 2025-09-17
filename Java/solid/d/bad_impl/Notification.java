package org.example.solid.d.bad_impl;

public class Notification {

    private EmailClient emailClient = new EmailClient(); // Direct dependency

    public void send() {
        emailClient.sendEmail();
    }
}
