# CSE 332: Dictionaries

A **[[Dictionary]]** (or Map) is an Abstract Data Type (ADT) that stores sets of key-value pairs where keys must be comparable.

### Operations
- `insert(key, value)`: Adds the `(key, value)` pair into the dictionary. If the key already has a value, it overwrites the old value. Consequently, keys cannot be repeated.
- `find(key)`: Returns the value associated with the given key.
- `delete(key)`: Removes the key and its associated value.

### Naïve Attempts & Time Complexities

| Data Structure | Time to insert | Time to find | Time to delete |
| --- | --- | --- | --- |
| Unsorted Array | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ |
| Unsorted Linked List | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ |
| Sorted Array | $\Theta(n)$ | $\Theta(\log n)$ | $\Theta(n)$ |
| Sorted Linked List | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ |
| **[[Binary Heap]]** | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ |
| **[[Binary Search Tree]]** | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ |
| **[[AVL Tree]]** | $\Theta(\log n)$ | $\Theta(\log n)$ | $\Theta(\log n)$ |

*Note: For a sorted array, we can use binary search to `find` in $\Theta(\log n)$ time, but inserting and deleting require shifting elements, taking $\Theta(n)$ time.*

### Related
- [[Binary Search Trees]]
- [[AVL Trees]]
