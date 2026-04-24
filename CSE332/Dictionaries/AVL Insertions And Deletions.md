# CSE 332: AVL Insertions And Deletions

When modifying an **[[AVL Tree]]**, the tree might become "out of balance". If an insertion or deletion breaks the Balance Property, the tree is repaired using **Rotations** at the deepest unbalanced node.

### Node Structure
To efficiently check the balance property, each node tracks its `Height` in addition to its `Key`, `Value`, `Left child`, and `Right child`.

### Insert Summary
1. Insert the new node just like a standard **[[Binary Search Tree]]** insertion.
2. Update the heights of the node's ancestors from leaf to root.
3. Check if each node is balanced.
4. If unbalanced, perform rotations at the **deepest unbalanced node**.

#### Rotation Cases for Insertion
Identify the deepest problem node and determine where the insertion occurred relative to it:
- **Case LL** (Left-Left): Inserted in the left subtree of the left child.
  - *Fix*: Perform a **Right Rotation** at the unbalanced node.
- **Case RR** (Right-Right): Inserted in the right subtree of the right child.
  - *Fix*: Perform a **Left Rotation** at the unbalanced node.
- **Case LR** (Left-Right): Inserted into the right subtree of the left child.
  - *Fix*: Requires two rotations. First, rotate Left at the left child. Then, rotate Right at the root (problem node).
- **Case RL** (Right-Left): Inserted into the left subtree of the right child.
  - *Fix*: Requires two rotations. First, rotate Right at the right child. Then, rotate Left at the root (problem node).

### Delete Summary
1. Delete the node just like a standard BST deletion.
2. Update the heights of the node's ancestors from leaf to root.
3. Check if each node is unbalanced.
4. If unbalanced, perform rotations at the **deepest unbalanced node**.
5. **Continue checking** up the tree until the root is reached (unlike insertion, a deletion fix may cause an imbalance higher up).

#### Rotation Cases for Deletion
The cases are identified by where the deletion occurred.
- **Case LL**: Deleted in the left subtree of the left child. $\rightarrow$ Rotate Left.
- **Case RR**: Deleted in the right subtree of the right child. $\rightarrow$ Rotate Right.
- **Case LR**: Deleted into the right subtree of the left child. $\rightarrow$ Rotate Right at left child, then Left at root.
- **Case RL**: Deleted into the left subtree of the right child. $\rightarrow$ Rotate Left at right child, then Right at root.

### Visualizing Rotations
- **Right Rotation** at node $a$ (where $b$ is $a$'s left child): Make $b$ the new root, make $a$ the right child of $b$, and make $b$'s original right subtree the left subtree of $a$.
- **Left Rotation** at node $a$ (where $b$ is $a$'s right child): Make $b$ the new root, make $a$ the left child of $b$, and make $b$'s original left subtree the right subtree of $a$.

### Related
- [[AVL Trees]]
