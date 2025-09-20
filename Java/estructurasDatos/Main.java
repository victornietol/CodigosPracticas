package org.example.estructurasDatos;

import org.example.estructurasDatos.Nodo.DoubleNode;
import org.example.estructurasDatos.Nodo.Node;

public class Main {
    public static void main(String[] args) {
        Node<Integer> n1 = new Node<>(1);
        Node<String> n2 = new Node<>("Dos");
        Node<Double> n3 = new Node<>(3.5);
        Node<Prueba4> n4 = new Node<>(new Prueba4("Soy 4to"));
        Node<Integer> n5 = new Node<>(5);

        DoubleNode<Integer> dn1 = new DoubleNode<>(1);


        SimpleLinkedList simpleLinkedList = new SimpleLinkedList<>(0);
        simpleLinkedList.insertFist(n1);
        simpleLinkedList.insertFist(n2);
        simpleLinkedList.insertLast(n3);
        simpleLinkedList.insertInPosition(2,n4);
        System.out.println(simpleLinkedList);
        simpleLinkedList.deleteFirst();
        System.out.println(simpleLinkedList);
        simpleLinkedList.insertInPosition(10,n5);
        System.out.println(simpleLinkedList);
        simpleLinkedList.deletePosition(2);
        System.out.println(simpleLinkedList);
        simpleLinkedList.deleteElement(n1);
        simpleLinkedList.deleteElement(5);
        System.out.println(simpleLinkedList);
    }
}




class Prueba4{
    private String message;

    public Prueba4(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "Prueba4: " + this.message;
    }
}