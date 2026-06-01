# Parallel: Partitioned Hash Join

The most common parallel join algorithm is the **Partitioned Hash Join** (a parallel equijoin).

1. **Hash Shuffle**: Both input relations are [[The Shuffle Operator|shuffled]] across nodes using a hash function on the join attribute. This ensures that any two tuples that could possibly match are sent to the same node.
2. **Local Join**: Each node performs a standard **hash join** (e.g., Grace Join) on its local partitions.

![[Partitioned Hash Equijoin Algorithm.png]]
![[Multiple Shuffles.png]]

## Algorithm Walkthrough
Consider the join $R \bowtie_{A=B} S$ over $R(K_1, A, C)$ and $S(K_2, B, D)$, run across $P$ servers:

- **Step 1 — Partition**: Every server holding any chunk of $R$ partitions its chunk with the hash function $h(t.A) \bmod P$, and every server holding any chunk of $S$ partitions its chunk with $h(t.B) \bmod P$. Because both relations are hashed on their join attribute, matching tuples are guaranteed to land on the same server.
- **Step 2 — Local Join**: Each server computes the join of its local fragment of $R$ with its local fragment of $S$.

![[Parallel Join Example.png]]

## Broadcast Join (Optimizing for Small Relations)
When joining $R$ and $S$ where one relation is far smaller — $|R| \gg |S|$ — hashing both is wasteful:

- **Leave $R$ where it is** (no shuffle) and **replicate the entire $S$ relation** to every node instead of hash-shuffling it.
- Since every node now holds a local copy of $S$, each can do a **local join** against its existing $R$ fragment.
- Only one (small) relation crosses the network, which saves a huge amount of network cost.
- This is also called a **small join** or **broadcast join**.

---

## Related

- [[Database Internals/Parallel/Parallel Query Execution|Parallel Query Execution]] — parent hub for parallel operators
- [[The Shuffle Operator|The Shuffle Operator]] — the hash-shuffle step that co-locates matching tuples
- [[Data Partitioning Schemes|Data Partitioning Schemes]] — when a relation is already hash-partitioned on the join key, Step 1 can be skipped; see also skew-join handling for heavy-hitter keys
- [[Partitioned Hash Algorithms|Partitioned Hash Join (Grace Join)]] — the single-node hash join used locally in Step 2

---

## Industry Standard Terms

| Course Term | Industry / Real-World Equivalent |
|---|---|
| Partitioned Hash Join | Parallel Hash Join; Shuffled Join |
| Broadcast Join | Map-side join; Replicated join |
