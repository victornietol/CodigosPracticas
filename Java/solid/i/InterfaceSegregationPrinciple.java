package org.example.solid.i;


import org.example.solid.i.good_impl.Human;

/**
 * Interface Segregation Principle
 * Clients should not be forced to depend on interfaces or methods they do not use. It´s better to have many small, specific interfaces than one large,
 * general-porpuse one.
 *
 * BAD: A "fat" interface forces the Robot class to implement eat().
 * GOOD: Smaller, more specific interfaces ("role interfaces")
 */
public class InterfaceSegregationPrinciple {

    public static void main(String[] args) {

        // bad
        org.example.solid.i.bad_impl.Robot badRobot = new org.example.solid.i.bad_impl.Robot();
        badRobot.work();
        badRobot.eat(); // robot doesn´t eat

        // good
        org.example.solid.i.good_impl.Robot goodRobot = new org.example.solid.i.good_impl.Robot();
        goodRobot.work();

        Human human = new Human();
        human.work(); // implements two interfaces
        human.eat();
    }
}
