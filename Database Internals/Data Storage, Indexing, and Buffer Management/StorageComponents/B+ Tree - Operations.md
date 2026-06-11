# Database Internals: B+ Tree - Operations

The operations below work on a [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/B+ Tree - Properties and Structure|B+ Tree]] with degree $d$ — meaning every non-root node holds between $d$ and $2d$ keys. Each node corresponds to one disk page, so all costs below are in page reads/writes.

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

![[Insertion in a B+ tree.png]]

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

![[Deletion from a B+ Tree.png]]
![[Deletion from a B+ Tree 2.png]]

---

## Optimizations

- Common optimizations:
  - **Prefix compression**: store only the prefix of a key sufficient to distinguish children, saving space per node
  - **Relaxed minimum fill**: allow fill to drop slightly below 50% to reduce cascading splits and merges on frequent updates
  - **Bulk loading**: sort data first, then build the B+ tree bottom-up — far faster than repeated single inserts
  - **Transaction-safe locking**: tree-specific locking protocols (e.g., crabbing/coupling) instead of locking the whole tree with Strict 2PL
- For **multi-dimensional queries** (e.g., range on latitude AND longitude), B+ trees are inadequate — use **R-trees** or other spatial indexes (see [[Database Internals/Data Storage, Indexing, and Buffer Management/Advanced Indexing|Advanced Indexing]]) instead

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|---|---|
| Split | Page split / node split |
| Bulk Loading | Bottom-up build; sorted bulk insert |
| Prefix Compression | Key compression; prefix truncation |
| Crabbing / Lock Coupling | B-tree latch coupling (implementation-specific) |

## Related

- [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/B+ Tree - Properties and Structure|B+ Tree - Properties and Structure]] — degree, fan-out, height, and occupancy constraints
- [[Database Internals/Data Storage, Indexing, and Buffer Management/B+ Tree|B+ Tree]] — hub file
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Indexing|Indexing]] — clustered and unclustered indexes that use B+ trees
