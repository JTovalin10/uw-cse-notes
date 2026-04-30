# B+ Tree: Properties and Structure

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
