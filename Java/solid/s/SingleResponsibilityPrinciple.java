package org.example.solid.s;


import org.example.solid.s.bad_impl.User;
import org.example.solid.s.good_impl.UserRepository;

/**
 * Single Responsibility Principle
 * A class should have only one job or one reason to change
 *
 * BAD: A class doing two jobs (managing user data and saving it)
 * GOOD: Each class has a single, clear porpuse.
 */
public class SingleResponsibilityPrinciple {
    public static void main(String[] args) {

        // Bad
        org.example.solid.s.bad_impl.User userBad = new org.example.solid.s.bad_impl.User("user");
        userBad.saveUserToDatabase();

        // Good
        org.example.solid.s.good_impl.User userGood = new org.example.solid.s.good_impl.User("user");
        UserRepository repository = new UserRepository();
        repository.save(userGood);
    }
}
