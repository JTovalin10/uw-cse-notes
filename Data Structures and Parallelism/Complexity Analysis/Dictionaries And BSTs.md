# CSE 332: Dictionaries and BSTs

A **[[Dictionary ADT|Dictionary]]** is an ADT that maps keys to values and supports insert, delete, and find. The BST is the canonical tree-based implementation of a dictionary.

## BST as a Dictionary Implementation

A **[[Binary Search Trees|Binary Search Tree]]** stores key-value pairs in a tree obeying the **order property**: all keys in the left subtree are smaller than the root, and all keys in the right subtree are larger.

### Operation Complexities

| Operation | Best Case | Average Case | Worst Case |
|---|---|---|---|
| `find` | $O(1)$ | $O(\log n)$ | $O(n)$ |
| `insert` | $O(1)$ | $O(\log n)$ | $O(n)$ |
| `delete` | $O(1)$ | $O(\log n)$ | $O(n)$ |

The worst case $O(n)$ occurs when the tree degenerates into a linked list (e.g., inserting keys in sorted order). The height $h$ of a balanced BST with $n$ nodes is $\Theta(\log n)$, giving $O(\log n)$ operations — but an unbalanced BST can reach height $\Theta(n)$.

## Why BSTs Are Insufficient Alone

The problem with plain BSTs is that there is no guarantee of balance. A sequence of inserts in sorted order produces a tree of height $n - 1$, making all operations $O(n)$ — no better than a linked list.

This motivates **self-balancing** trees such as [[AVL Trees|AVL Trees]], which maintain $h = O(\log n)$ after every insert and delete, guaranteeing $O(\log n)$ worst-case for all dictionary operations.

## Related
- [[Binary Search Trees|Binary Search Trees]] — full BST operations and implementation
- [[Dictionaries|Dictionaries]] — the ADT specification
- [[AVL Trees|AVL Trees]] — self-balancing BST solving the worst-case problem
- [[Algorithm Analysis|Algorithm Analysis]] — how to measure operation costs
- [[Asymptotic Notation|Asymptotic Notation]] — $O$, $\Omega$, $\Theta$ notation used above
