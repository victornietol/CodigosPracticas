package org.example.estructurasDatos;

import org.example.estructurasDatos.Nodo.DoubleNode;

public class DoubleLinkedList implements Insert{

    private DoubleNode head;
    private int numberNodes = 0;

    public DoubleLinkedList(Object head){
        this.head = new DoubleNode<>(head);
        sumNumberNodes();
    }

    @Override
    public Object insertFist(Object node) {
        DoubleNode nodeInsert = node instanceof DoubleNode ? (DoubleNode) node : new DoubleNode<>(node);
        nodeInsert.setNext(this.head);
        this.head.setPrev(nodeInsert);
        this.head = nodeInsert;
        sumNumberNodes();
        return this.head;
    }

    @Override
    public Object insertLast(Object node) {
        DoubleNode currNode = this.head;
        DoubleNode nodeInsert = node instanceof DoubleNode ? (DoubleNode) node : new DoubleNode<>(node);
        boolean inserted = false;
        while (!inserted) {
            if (currNode.getNext()==null) {
                nodeInsert.setPrev(currNode);
                currNode.setNext(nodeInsert);
                inserted = true;
                sumNumberNodes();
            }
            currNode = currNode.getNext();
        }
        return nodeInsert;
    }

    @Override
    public Object insertInPosition(int position, Object node) {
        if (position<0) {
            return null;
        }

        DoubleNode nodeInsert = node instanceof DoubleNode ? (DoubleNode) node : new DoubleNode<>(node);

        if (position==0) {
            insertFist(nodeInsert);
        }
        else if (position >= this.numberNodes) {
            insertLast(nodeInsert);
        }
        else {
            DoubleNode currNode = this.head;
            for (int i=0; i<position; i++) {
                if (i+1 == position) {
                    nodeInsert.setPrev(currNode);
                    nodeInsert.setNext(currNode.getNext());
                    currNode.getNext().setPrev(nodeInsert);
                    currNode.setNext(nodeInsert);
                    sumNumberNodes();
                }
                currNode = currNode.getNext();
            }
        }
        return nodeInsert;
    }

    private void delNumberNodes(){
        this.numberNodes--;
    }

    private void sumNumberNodes(){
        this.numberNodes++;
    }

    public int length() {
        return this.numberNodes;
    }

    @Override
    public String toString() {
        StringBuilder str = new StringBuilder("DoubleLinkedList{head="+head);
        DoubleNode currNode = this.head;
        while (currNode.getNext()!=null) {
            str.append(", ");
            str.append(currNode.getNext());
            currNode = currNode.getNext();
        }
        str.append("}");
        return str.toString();
    }
}
