# CSE 332: AVL Trees

An **[[AVL Tree]]** is a "balanced" **[[Binary Search Tree]]** that enforces strict shape rules to guarantee $\Theta(\log n)$ worst-case running times by preventing the tree from becoming too tall or sparse.

### Invariants
An AVL Tree must maintain both:
1. **BST Order Property**: All keys in the left subtree are smaller than the root, right subtree larger.
2. **Balance Property**: The height of the left subtree and the height of the right subtree of *every* node differ by at most 1.

### Time Complexities
Because the tree remains balanced, the maximum height $h$ for $n$ nodes is constrained.
- `insert`: $\Theta(\log n)$
- `find`: $\Theta(\log n)$
- `delete`: $\Theta(\log n)$

### Height Analysis
Let $M(h)$ be the minimum count of nodes in an AVL tree of height $h$.
An AVL tree of height $h$ must have one subtree of height $h - 1$, meaning the other subtree has a height of at least $h - 2$.
$$M(h) = M(h-1) + M(h-2) + 1$$
This recurrence resembles the Fibonacci sequence $F(n) = F(n-1) + F(n-2)$. 
For large values of $h$, $M(h) > F(h) \approx \phi^h$, where $\phi > 1.6$ is the golden ratio.
Therefore, an AVL tree of height $h$ has at least $\phi^h$ nodes. Solving for $h$, we get $h \le \log_\phi(n)$. Thus, operations run in $\Theta(\log n)$ time.

### Implementation (Rotations)
```java
private AVLNode rotateRight(AVLNode y) {
    AVLNode x = y.left;
    AVLNode T2 = x.right;
    x.right = y;
    y.left = T2;
    updateHeight(y);
    updateHeight(x);
    return x;
}

private AVLNode rotateLeft(AVLNode x) {
    AVLNode y = x.right;
    AVLNode T2 = y.left;
    y.left = x;
    x.right = T2;
    updateHeight(x);
    updateHeight(y);
    return y;
}

// Double rotations
private AVLNode doubleRotateLeftRight(AVLNode node) {
    node.left = rotateLeft(node.left);
    return rotateRight(node);
}

private AVLNode doubleRotateRightLeft(AVLNode node) {
    node.right = rotateRight(node.right);
    return rotateLeft(node);
}
```

### Related
- [[Binary Search Trees]]
- [[AVL Insertions And Deletions]]
