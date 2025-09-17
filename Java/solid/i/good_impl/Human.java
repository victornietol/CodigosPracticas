package org.example.solid.i.good_impl;

// Can implement multiple small interfaces
public class Human implements Workable, Eatable{

    @Override
    public void work() {
        //logic
    }

    @Override
    public void eat() {
        //logic
    }
}
