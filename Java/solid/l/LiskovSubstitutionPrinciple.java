package org.example.solid.l;

/**
 * Liskov Substitution Principle
 * If you have a class A, any class B that inherits from A should be able to replace A
 * without causing any errors. In short, child classes should be perfectly substitutable
 * for their parent classes.
 *
 * BAD: A subclass changes the behavior of the parent, breaking expectations. A penguin can´t fly
 * GOOD: Create a more suitable abstraction so subtypes don´t need to break parent behavior.
 */
public class LiskovSubstitutionPrinciple {
    public static void main(String[] args) {

    }
}
