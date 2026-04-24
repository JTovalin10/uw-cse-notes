# CSE 332: Binary Search Trees

A **[[Binary Search Tree]]** (BST) is a binary tree where each node has at most 2 children and maintains a specific order property.

### Invariants
- **Binary Tree Property**: Each node has $\le 2$ children.
- **Order Property**: All keys in the left subtree are smaller than the root, and all keys in the right subtree are larger than the root. Keys cannot be repeated.

### Time Complexities
For a tree of height $h$, the worst-case time for `find`, `insert`, and `delete` matches the height of the tree, which is $O(h)$.
In the worst case (a degenerate "sparse" tree resembling a linked list), the maximum height of a BST with $n$ nodes is $\Theta(n)$.

### Operations
- **Find**: Recursively or iteratively traverse left if the target key is less than the current node's key, and right if it's greater.
- **Insert**: Traverse the tree exactly like `find` until reaching a leaf (`Null`), and place the new node there.
- **Delete**: 
  - **0 Children (Leaf)**: Remove the node.
  - **1 Child**: Replace the deleted node with its child.
  - **2 Children**: Replace the deleted node with the maximum node in its left subtree (the right-most thing) or the minimum node in its right subtree (the left-most thing).

### Representation
Unlike Binary Heaps (which use arrays), BSTs are represented with nodes and references (pointers) because they can have "gaps" in the tree, which would waste $\Theta(2^n)$ memory if represented as an array.

### Implementation
```java
public class BSTNode {
    int key;
    BSTNode left, right;

    public BSTNode(int key) {
        this.key = key;
    }
}

public BSTNode find(BSTNode root, int key) {
    if (root == null || root.key == key) {
        return root;
    }
    if (key < root.key) {
        return find(root.left, key);
    }
    return find(root.right, key);
}

public BSTNode insert(BSTNode root, int key) {
    if (root == null) {
        return new BSTNode(key);
    }
    if (key < root.key) {
        root.left = insert(root.left, key);
    } else if (key > root.key) {
        root.right = insert(root.right, key);
    }
    return root;
}
```

### Related
- [[Dictionaries]]
- [[AVL Trees]]
