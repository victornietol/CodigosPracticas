package org.example.solid.d;


/**
 * Dependency Inversion Principle
 * High-level modules (your main business logic) should not depend on low-level modules (like  a specific database or a payment gateway). Both
 * should depend on abstraction (like a generic Database interface).
 *
 * BAD: The high-level Notification class depends directly on the low-level EmailClient
 * GOOD: Both classes depend on an abstraction
 */
public class DependencyInversionPrinciple {
    public static void main(String[] args) {

        // bad
        org.example.solid.d.bad_impl.Notification badNotification = new org.example.solid.d.bad_impl.Notification();
        // depends directly on EmailClient
        badNotification.send();


        // good
        org.example.solid.d.good_impl.EmailClient goodEmailClient = new org.example.solid.d.good_impl.EmailClient();
        // received implementation of MessageClient
        org.example.solid.d.good_impl.Notification goodNotification = new org.example.solid.d.good_impl.Notification(goodEmailClient);
        goodNotification.send();
    }
}
