package org.example.estructurasDatos.ejercicios.repaso_estructuras;

public class Main {
    public static void main(String[] args) {
        DoubleLinkedList dll = new DoubleLinkedList();
        dll.addLast(1);
        dll.addLast(2);
        dll.addLast(3);
        dll.addLast(4);
        dll.addLast(5);
        dll.addFirst(-1);
        dll.addFirst(-2);
        dll.addFirst(-3);
        dll.addFirst(-4);
        dll.addFirst(-5);
        System.out.print("Lista del primero al ultimo: ");
        dll.seeAll();
        System.out.print("Lista del ultimo al primero: ");
        dll.seeReverse();

        System.out.println("------------QUEUE-------------");
        Queue queue = new Queue();
        queue.enqueue(1);
        queue.enqueue(2);
        queue.enqueue(3);
        queue.enqueue(4);
        queue.enqueue(5);
        queue.seeElements();
        Object retired = queue.dequeue();
        queue.seeElements();
        System.out.println("Retirado: " + retired);

        System.out.println("------------STACK-------------");
        Stack stack = new Stack();
        stack.push(1);
        stack.push(2);
        stack.push(3);
        stack.push(4);
        stack.push(5);
        stack.seeElements();
        retired = stack.pop();
        stack.seeElements();
        System.out.println("Retirado: " + retired);

    }
}
