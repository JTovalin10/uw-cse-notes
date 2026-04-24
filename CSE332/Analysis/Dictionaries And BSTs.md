# CSE 332: Dictionaries and BSTs

## Dictionary (Map) ADT
The **[[Dictionary ADT]]** stores sets of key-value pairs. 
- Keys must be comparable.
- Keys cannot be repeated; inserting an existing key overwrites the old value.

### Operations
- `insert(key, value)`: Adds the pair into the dictionary.
- `find(key)`: Returns the value associated with the given key.
- `delete(key)`: Removes the key and its value from the dictionary.

### Naïve Implementation Complexities
| Data Structure | Time to Insert | Time to Find | Time to Delete |
| :--- | :---: | :---: | :---: |
| Unsorted Array | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ |
| Unsorted Linked List | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ |
| Sorted Array | $\Theta(n)$ | $\Theta(\log n)$ | $\Theta(n)$ |
| Sorted Linked List | $\Theta(n)$ | $\Theta(n)$ | $\Theta(n)$ |

## Binary Search Trees (BST)
A **[[Binary Search Tree]]** is a binary tree (each node has at most 2 children) that enforces the **Order Property**:
- All keys in the left subtree are strictly smaller than the root.
- All keys in the right subtree are strictly larger than the root.

### Complexities
- **Worst-case**: $\Theta(n)$ for `insert`, `find`, and `delete` (e.g., if the tree becomes a skewed "stick").
- **Expected**: $\Theta(\log n)$ for `insert`, `find`, and `delete` (when the tree is relatively balanced).

### Tree Traversals
Algorithms to visit every node in a tree:
- **Pre-Order**: Root, Left Subtree, Right Subtree
- **In-Order**: Left Subtree, Root, Right Subtree (Visits BST keys in sorted order)
- **Post-Order**: Left Subtree, Right Subtree, Root

### Operations in BST
- **Find**: Iteratively or recursively compare the key with the root. If smaller, go left; if larger, go right.
- **Insert**: Search for the key until hitting a `null` reference, then attach a new node. Inserts always happen at the leaves.
- **Delete**: 
  - **Case 0 (Leaf)**: Just remove the node (make parent point to `null`).
  - **Case 1 (One Child)**: Replace the deleted node with its single child.
  - **Case 2 (Two Children)**: Replace the deleted node's value with its predecessor (the maximum node in the left subtree) or successor (the minimum node in the right subtree), then delete that predecessor/successor.

## Related
- [[Algorithm Analysis]]
- [[Recurrences]]