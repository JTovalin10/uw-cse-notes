# CSE444: B+ Tree

---

A **B+ tree** is a **balanced search tree** optimized for disk-page access. It is the default index structure in most relational DBMSs.

**B-tree idea:**
- One node = one page (one disk block)
- Maximize branching factor (number of children per node) to minimize height
- Keep tree height small to minimize the number of page reads needed per lookup

**B+ tree additions over a plain B-tree:**
- All data lives at the **leaves** — internal nodes store only separator keys to guide search
- **Leaves are linked** in a doubly-linked list, enabling efficient range scans
- Each node access = one page read (which is expensive — the whole point is to minimize tree height)

![[Screenshots/B+ Tree example.png]]

---

## Properties

- Every non-root node must be **at least 50% full** (at least $d$ keys)
- Insertions and deletions must rebalance the tree to maintain this constraint
- The tree is always perfectly height-balanced (all leaves at the same depth)

---

## Structure and Degree

- **Parameter $d$** = the degree (order) of the tree
- Each **internal node** has $d \leq m \leq 2d$ keys (except the root, which may have fewer)
- Each internal node with $m$ keys has $m + 1$ child pointers

![[Screenshots/B+ tree node pointers.png]]

- Each **leaf node** has $d \leq m \leq 2d$ key/pointer pairs

![[Screenshots/B+ tree leaf keys.png]]

### Computing $d$ for a Given Page Size

Given:
- Key size = 4 bytes
- Pointer size = 8 bytes
- Block (page) size = 4096 bytes

Fit $2d$ keys and $2d + 1$ pointers into one page:

$$2d \times 4 + (2d + 1) \times 8 \leq 4096 \implies d = 170$$

---

## Practical Performance

- Typical order: $d = 100$, typical fill factor: 66%
  - Average node fanout (children per internal node) = $200 \times 0.66 = 133$
- Typical capacities:
  - Height 3: $133^3 \approx 2{,}352{,}637$ records
  - Height 4: $133^4 \approx 312{,}900{,}700$ records
- Upper levels are frequently **cached in the buffer pool**:
  - Level 1: 1 page ≈ 1 KB
  - Level 2: 133 pages ≈ 1 MB
  - Level 3: 17,689 pages ≈ 133 MB (often fits in memory)

This means that in practice, most B+ tree lookups cost only **1–2 disk I/Os** for the leaf, since higher levels are already in the buffer pool.

---

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

## Summary and Optimizations

- **Default index structure** in most relational DBMSs (PostgreSQL, MySQL, Oracle, etc.)
- Common optimizations:
  - **Prefix compression**: store only the prefix of a key sufficient to distinguish children, saving space per node
  - **Relaxed minimum fill**: allow fill to drop slightly below 50% to reduce cascading splits and merges on frequent updates
  - **Bulk loading**: sort data first, then build the B+ tree bottom-up — far faster than repeated single inserts
  - **Transaction-safe locking**: tree-specific locking protocols (e.g., crabbing/coupling) instead of locking the whole tree with Strict 2PL
- For **multi-dimensional queries** (e.g., range on latitude AND longitude), B+ trees are inadequate — use **R-trees** or other spatial indexes instead

---

## Related

- [[CSE444/Data Storage, indexing, and buffer mgmt/Indexing|Indexes and File Organizations]] — clustered/unclustered indexes, dense/sparse indexes, and how B+ trees fit into file organizations
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats and buffer pool management
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture]] — how the storage manager and buffer manager use index structures
- [[CSE332/README|CSE332]] (Balanced Trees)
- [[CSE344/Database Design/Database Indices|Database Indices]] — CSE344 overview of index structures
- [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — clustered vs. unclustered index design
