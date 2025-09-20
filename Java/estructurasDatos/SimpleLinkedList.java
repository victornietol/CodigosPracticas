package org.example.estructurasDatos;

import org.example.estructurasDatos.Nodo.Node;

public class SimpleLinkedList<T> implements Insert, Delete {

    private Node<T> head;

    public SimpleLinkedList(T element){
        this.head = new Node<>(element);
    }


    @Override
    public boolean deleteLast() {
        return false;
    }

    @Override
    public boolean deleteFirst() {
        return false;
    }

    @Override
    public boolean deletePosition() {
        return false;
    }

    @Override
    public boolean deleteElement(Object element) {
        return false;
    }

    @Override
    public Object insertFist(Object node) {
        if (node instanceof Node) {
            Node<T> nodeC = (Node<T>) node;
            nodeC.setNext(this.head);
            this.head = nodeC;
            return node;
        }
        return null;
    }

    @Override
    public Object insertLast(Object node) {
        if (node instanceof Node) {
            Node<T> nodeC = (Node<T>) node;
            boolean inserted = false;
            Node currNode = this.head;
            while(!inserted) {
                if(currNode.getNext()==null) {
                    currNode.setNext(nodeC);
                    inserted = true;
                }
                currNode = currNode.getNext();
            }
            return node;
        }
        return null;
    }

    @Override
    public Object insertInPosition(int position, Object node) {
        if (position>=0 && node instanceof Node) {
            Node<T> nodeC = (Node<T>) node;

            if (position==0) {
                insertFist(nodeC);
                return 0;
            }

            Node currNode = this.head;
            for (int i=0; i<=position; i++) {
                if (i+1 == position) {
                    nodeC.setNext(currNode.getNext());
                    currNode.setNext(nodeC);
                    return position;
                }
                currNode = currNode.getNext();
            }

        }
        return null;
    }

    @Override
    public String toString() {
        return "SimpleLinkedList{" +
                "head=" + head +
                '}';
    }
}
