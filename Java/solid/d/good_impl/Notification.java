package org.example.solid.d.good_impl;

// high-level class depends on the interface, not the concrete class
public class Notification {
    private MessageClient client;

    //the specific client is "injected"
    public Notification(MessageClient client) {
        this.client = client;
    }

    public void send(){
        client.sendMessage();
    }
}
