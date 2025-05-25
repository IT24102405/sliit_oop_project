package com.inventory.product;

import java.util.Iterator;

public class Stack<T> implements Iterable<T> {
    private final Object[] array;
    private int top;

    public Stack(int size) {
        array = new Object[size];
        top = -1;
    }

    public void push(T item) {
        if (isFull()) throw new RuntimeException("Stack is full");
        array[++top] = item;
    }

    @SuppressWarnings("unchecked")
    public T pop() {
        if (isEmpty()) throw new RuntimeException("Stack is Empty");
        return (T) array[top--];
    }

    @SuppressWarnings("unchecked")
    public T peek() {
        if (isEmpty()) throw new RuntimeException("Stack is Empty");
        return (T) array[top];
    }

    public boolean isEmpty() {
        return top == -1;
    }

    public boolean isFull() {
        return top == array.length - 1;
    }

    @Override
    public Iterator<T> iterator() {
        return new Iterator<>() {
            private int point = 0;
            private final Object[] arr = Stack.this.array;

            @Override
            public boolean hasNext() {
                return point >= 0 && arr[point] != null;
            }

            @Override
            @SuppressWarnings("unchecked")
            public T next() {
                return (T) arr[point++];
            }
        };
    }
}
