package org.example.estructurasDatos;

import org.example.estructurasDatos.Nodo.DoubleNode;
import org.example.estructurasDatos.Nodo.Node;

public class Main {
    public static void main(String[] args) {

        // Lista ligada simple
        Node<Integer> n1 = new Node<>(1);
        Node<String> n2 = new Node<>("Dos");
        Node<Double> n3 = new Node<>(3.5);
        Node<Prueba4> n4 = new Node<>(new Prueba4("Soy 4to"));
        Node<Integer> n5 = new Node<>(5);

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
        simpleLinkedList.insertLast(20);
        simpleLinkedList.insertFist(-1);
        simpleLinkedList.insertInPosition(1, 11);
        System.out.println(simpleLinkedList);


        // Lista doblemente ligada
        DoubleLinkedList dll = new DoubleLinkedList(1);
        dll.insertLast(2);
        DoubleNode<Integer> dn3 = new DoubleNode<>(3);
        dll.insertLast(dn3);
        dll.insertFist(0);
        System.out.println(dll);
        dll.insertInPosition(10, 10);
        dll.insertInPosition(0, -1);
        System.out.println(dll);
        dll.insertInPosition(3, 1.5);
        dll.insertInPosition(6, 9);
        System.out.println(dll);
        System.out.println(dll.length());
        

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