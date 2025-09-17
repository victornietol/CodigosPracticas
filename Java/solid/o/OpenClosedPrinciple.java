package org.example.solid.o;


import java.awt.*;

/**
 * Software should be open for extension, but closed for modification.
 * Means one should be able to add new features without changing the existing , testedc code.
 * BAD: Adding a new shape requires modifying the AreaCalculator class.
 * GOOD: Add new shapes without changing AreaCalculator.
 */
public class OpenClosedPrinciple {
    public static void main(String[] args) {

        // bad
        org.example.solid.o.bad_impl.AreaCalculator calculatorBad = new org.example.solid.o.bad_impl.AreaCalculator();
        calculatorBad.calculateArea(new Rectangle());

        //good
        org.example.solid.o.good_impl.AreaCalculator calculatorGood = new org.example.solid.o.good_impl.AreaCalculator();
        calculatorGood.calculateArea(new org.example.solid.o.good_impl.Rectangle());
    }
}
