package org.example.estructurasDatos.ejercicios.repaso_estructuras;

public class DoubleLinkedList {

    private Node head;
    private Node last;

    public DoubleLinkedList() {}

    /**
     * Regresa y elimina el ultimo nodo
     * @return Ultimo nodo de la lista
     */
    public Node returnLast() {
        Node oldLast = last;
        last.getPrev().setNext(null);
        last = oldLast.getPrev();
        oldLast.setPrev(null);
        return oldLast;
    }

    /**
     * Regresa y elimina el primer nodo
     * @return Primer nodo de la lista
     */
    public Node returnHead() {
        Node oldHead = head;
        head = head.getNext();
        head.setPrev(null);
        oldHead.setNext(null);
        return oldHead;
    }

    public void addFirst(Object object) {
        if (head == null) {
            head = new Node(object, null,null);
            last = head;
        }
        else {
            Node oldHead = head;
            Node newHead = new Node(object, null, head);
            oldHead.setPrev(newHead);
            head = newHead;
        }
    }

    public void addLast(Object object) {
        if (head == null) {
            addFirst(object);
        } else {
            if (last == null) {
                last = new Node(object, head, null);
                head.setNext(last);
            } else {
                Node oldLast = last;
                Node newNode = new Node(object, oldLast, null);
                oldLast.setNext(newNode);
                last = newNode;
            }
        }
    }

    public void seeAll() {
        Node currNode = head;
        StringBuilder str = new StringBuilder();
        while (currNode != null) {
            str.append(currNode.getObject());
            str.append(" -> ");
            currNode = currNode.getNext();
        }
        str.append("null");
        System.out.println(str);
    }

    public void seeReverse() {
        Node currNode = last;
        StringBuilder str = new StringBuilder();
        while (currNode != null) {
            str.append(currNode.getObject());
            str.append(" -> ");
            currNode = currNode.getPrev();
        }
        str.append("null");
        System.out.println(str);
    }

    public void seeFirst() {
        System.out.println(head.getObject());
    }

    public void seeLast() {
        System.out.println(last.getObject());
    }
}
