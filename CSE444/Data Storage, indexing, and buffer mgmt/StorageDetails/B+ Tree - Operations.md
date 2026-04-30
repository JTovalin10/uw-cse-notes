# B+ Tree: Operations

## API

### Lookup

Find all records with key $K$:
1. Start at root; follow child pointers using separator keys until a leaf is reached
2. Scan leaf (and linked neighbors for range queries)

Cost: $O(\log_{2d} n)$ page reads.

### Insertion

`Insert(K, P)`:
1. Find the leaf where $K$ belongs; insert $(K, P)$
2. If no overflow ($\leq 2d$ keys after insert) — done
3. If overflow ($2d + 1$ keys) — **split the node**:
   - For a leaf split: distribute keys evenly; push a copy of the middle key up to the parent (keep it in both children)
	   - leafs
   - For an internal node split: distribute keys; the middle key is pushed up (not kept in the children)
	   - middle layers
   - If the root splits, a **new root** is created with just one key

![[Screenshots/Insertion in a B+ tree.png]]

### Deletion

`Delete(K, P)`:
1. Find the leaf where $K$ belongs; delete the entry
2. If the leaf still has $\geq d$ keys — done
3. If below capacity, try to **borrow** from an adjacent sibling (check left first, then right):
   - Rotate the separator key and one entry from the sibling through the parent
4. If the adjacent sibling is exactly at capacity ($d$ keys) — **merge**:
   - Combine the two underfull nodes into one
   - Remove the separator key from the parent
   - Repeat the algorithm on the parent (which may itself become underfull)

![[Screenshots/Deletion from a B+ Tree.png]]
![[Screenshots/Deletion from a B+ Tree 2.png]]

---

## Optimizations

- Common optimizations:
  - **Prefix compression**: store only the prefix of a key sufficient to distinguish children, saving space per node
  - **Relaxed minimum fill**: allow fill to drop slightly below 50% to reduce cascading splits and merges on frequent updates
  - **Bulk loading**: sort data first, then build the B+ tree bottom-up — far faster than repeated single inserts
  - **Transaction-safe locking**: tree-specific locking protocols (e.g., crabbing/coupling) instead of locking the whole tree with Strict 2PL
- For **multi-dimensional queries** (e.g., range on latitude AND longitude), B+ trees are inadequate — use **R-trees** or other spatial indexes instead
