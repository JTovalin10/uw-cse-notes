# CSE 332: Priority Queues

**Priority Queue**: A collection of items and their "priorities" that allows quick access and removal to the "top priority" thing. Usually, a smaller priority value means the item is "more important".

### Operations
The core operations for a Priority Queue are:
- `insert(item, priority)`: Add a new item to the PQ with the indicated priority.
- `extract()`: Remove and return the "top priority" item from the queue (usually the item with the smallest priority value).
- `Is_empty()`: Indicate whether or not there are items still on the queue.

*Note: The "priority" value can be any type/class so long as it's comparable (i.e., you can use `<` or `compareTo` with it).*

### Time Complexities of Implementations

| Data Structure | Worst case time to insert | Worst case time to extract |
| --- | --- | --- |
| Unsorted Array | $\Theta(1)$ | $\Theta(n)$ |
| Unsorted Linked List | $\Theta(1)$ | $\Theta(n)$ |
| Sorted Array | $\Theta(n)$ | $\Theta(1)$ |
| Sorted Linked List | $\Theta(n)$ | $\Theta(1)$ |
| **[[Binary Search Tree]]** | $\Theta(n)$ | $\Theta(n)$ |
| **[[Binary Heap]]** | $\Theta(\log n)$ | $\Theta(\log n)$ |

*Assumption: For simplicity, assume we know the maximum size of the PQ in advance.*

### Related
- [[Binary Heaps]]
