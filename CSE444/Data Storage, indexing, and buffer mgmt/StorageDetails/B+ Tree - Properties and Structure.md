# CSE444: B+ Tree - Properties and Structure

A **B+ Tree** is a **balanced search tree** optimized for disk-page access. It is the default index structure in most relational DBMSs.

### B-tree Core Concepts
- **One node = one page**: Each node occupies exactly one disk block (e.g., 4KB or 8KB).
- **Branching Factor**: The goal is to maximize the number of children per node to minimize the tree's **Height**.
- **Minimal I/O**: A small tree height minimizes the number of page reads needed per lookup.

### B+ Tree Additions (vs. B-tree)
- **Leaf-Only Data**: All actual data records (or pointers to them) live at the **Leaves** — internal nodes store only separator keys to guide the search.
- **Linked Leaves**: Leaves are linked in a doubly-linked list, enabling efficient **Range Scans**.
- **Physical Access**: Each node access equals one page read (expensive); thus, the design focuses on reducing the path from root to leaf.

![[Screenshots/B+ Tree example.png]]

---

## Properties

- **Occupancy Constraint**: Every non-root node must be **at least 50% full** (at least $d$ keys).
- **Rebalancing**: Insertions and deletions must rebalance the tree to maintain this occupancy.
- **Perfect Balance**: The tree is always perfectly height-balanced (all leaves are at the same depth).

---

## Structure and Degree

- **Parameter $d$**: The **Degree** (or **Order**) of the tree.
- **Internal Nodes**: Each internal node has $d \leq m \leq 2d$ keys (except the root, which may have fewer).
- **Child Pointers**: Each internal node with $m$ keys has $m + 1$ child pointers.

![[Screenshots/B+ tree node pointers.png]]

- **Leaf Nodes**: Each leaf node has $d \leq m \leq 2d$ key/pointer pairs.

![[Screenshots/B+ tree leaf keys.png]]

### Computing $d$ for a Given Page Size

To compute the optimal degree, we must fit the maximum number of keys and pointers into a single page.

**Example Calculation:**
- Key size: 4 bytes
- Pointer size: 8 bytes
- Block (page) size: 4096 bytes

Equation to fit $2d$ keys and $2d + 1$ pointers:
$$2d \times 4 + (2d + 1) \times 8 \leq 4096 \implies d = 170$$

---

## Practical Performance

- **Standard Configuration**: Typical order $d = 100$, typical fill factor: 66%.
  - Average node **Fanout** (children per internal node) = $200 \times 0.66 = 133$.
- **Capacities**:
  - **Height 3**: $133^3 \approx 2{,}352{,}637$ records.
  - **Height 4**: $133^4 \approx 312{,}900{,}700$ records.
- **Caching**: Upper levels are frequently cached in the **[[CSE444/DBMS architecture and deployments/Subsystems/Buffer Manager|Buffer Pool]]**:
  - Level 1 (Root): 1 page $\approx$ 1 KB
  - Level 2: 133 pages $\approx$ 1 MB
  - Level 3: 17,689 pages $\approx$ 133 MB (often fits entirely in memory)

---

## Industry Standard Terms
- **Parameter d** $\rightarrow$ Order / Degree
- **Fanout** $\rightarrow$ Branching Factor
- **Leaf Pointers** $\rightarrow$ Sequence Set (in older literature)

## Related
- [[CSE444/Data Storage, indexing, and buffer mgmt/B+ Tree|B+ Tree Hub]] — operations and optimizations
- [[CSE444/Data Storage, indexing, and buffer mgmt/Indexing|Indexes and File Organizations]] — clustered vs. unclustered indexes
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats
- [[CSE332/Sorting/B-Trees|CSE332 Balanced Trees]]
