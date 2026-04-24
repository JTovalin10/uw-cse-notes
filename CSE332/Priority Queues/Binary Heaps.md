# CSE 332: Binary Heaps

A **[[Binary Heap]]** is a priority queue data structure that maintains a limited amount of order to achieve $\Theta(\log n)$ worst-case time for `extract` and `insert`. 

### Invariants
To be a valid Binary Heap, the tree must satisfy two invariants:
1. **Complete Tree Property**: The tree must be a complete binary tree. All "layers" are full, except the bottom layer, which is filled left-to-right.
2. **(Min) Heap Property**: Every node's priority is $\le$ its children's priority. (For a Max Heap, every node's priority is $\ge$ its children).

### Time Complexities
- `insert(item)`: $\Theta(\log n)$
- `extract()`: $\Theta(\log n)$
- `buildHeap()` (Floyd's Method): $\Theta(n)$

### Operations
- **Insert**: Put the item in the "next open" spot to keep the tree complete. Then, **Percolate Up**: repeatedly swap the item with its parent while its priority is less than its parent's priority.
- **Extract**: The minimum is always at the root. Move the bottom-right item (last leaf) to the root, then **Percolate Down**: repeatedly swap the current node with its smallest child until both children are larger than the current node.
- **Increase/Decrease Key**: Given the index of an item, change its priority and then percolate up or down to restore the heap property.

### Array Representation
A complete binary tree can be efficiently represented using an array.
- Index of root: `1`
- Parent of node $i$: $\lfloor i / 2 \rfloor$
- Left child of node $i$: $i \cdot 2$
- Right child of node $i$: $i \cdot 2 + 1$

*Visualization*: The root is at index 1. Its children are at indices 2 and 3. The children of node 2 are at 4 and 5, and so on. The leaves are located in the second half of the array.

### Floyd's `buildHeap` Method
To build a heap from an unsorted array of $n$ items from "scratch" in $\Theta(n)$ time:
Working towards the root, one row at a time, percolate down each node.
```java
for (int i = size; i > 0; i--) {
    percolateDown(i);
}
```

### Tree Height Analysis
- Maximum number of nodes in a binary tree of height $h$: $2^{h+1} - 1 = \Theta(2^h)$.
- Minimum height of $n$ nodes in a binary tree: $\Theta(\log n)$.

## Implementation
```java
private void percolateUp(int hole) {
    T tmp = array[hole];
    for (; hole > 1 && tmp.compareTo(array[hole / 2]) < 0; hole /= 2) {
        array[hole] = array[hole / 2];
    }
    array[hole] = tmp;
}

private void percolateDown(int hole) {
    int child;
    T tmp = array[hole];
    for (; hole * 2 <= size; hole = child) {
        child = hole * 2;
        if (child != size && array[child + 1].compareTo(array[child]) < 0) {
            child++;
        }
        if (array[child].compareTo(tmp) < 0) {
            array[hole] = array[child];
        } else {
            break;
        }
    }
    array[hole] = tmp;
}
```

### Related
- [[Priority Queues]]
