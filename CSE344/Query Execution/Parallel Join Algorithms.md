# CSE344: Parallel Join Algorithms

**Parallel joins** operate in the [[Parallel Query Execution#The Shared-Nothing Model|shared-nothing model]]. The core idea: shuffle related values onto the same node, then perform a local join.

## Partitioned Hash Join

Same basic idea as [[Parallel Query Execution#Partitioned Aggregation|partitioned aggregation]]:
1. Reshuffle tuples on the join key(s) so matching keys land on the same node
2. Local join on each node
3. Collect and union results

Not to be confused with [[External Memory Algorithms#GRACE Join (Partitioned Hash Join)|GRACE Join]], which is a single-node external memory algorithm.

![[Partitoned Hash Join.png]]

## Broadcast Join

Very different from partitioned hash join:
1. Broadcast the entirety of the smaller (unpartitioned) table to every node
2. Local join on each node
3. Collect results

A specialized algorithm for when one relation is small:
- No need to transfer the (possibly skewed) larger relation's data
- Requires one relation to be small enough to fit in memory on each node

![[Broadcast Join.png]]

## Skew Join

Used when hash-partitioning would create skew due to **heavy hitters** — specific attribute values that occur far too frequently.

### Virtual Servers / Task-Based Scheduling

- Divide data into $T$ tasks where $T \gg P$
- Execute $T$ tasks on $P$ servers, either directly (task-based scheduling) or via virtual servers
- Requires a scheduler — round-robin usually suffices

### Skewed Data and Heavy Hitters

When we hash-partition $R(A, B, ...)$ using $\text{hash}(R.A)$, skew occurs when a specific value $v$ occurs too often — we call $v$ a **heavy hitter**.

![[Skew Data.png]]

#### Identifying Heavy Hitters

![[Identifying heavy hitters.png]]

### Skew Join Algorithm

A clever combination of partitioned hash join and broadcast join:
1. Identify the heavy values in $R$
2. Use **partitioned hash join** for the light values
3. Use **broadcast join** for $S$'s heavy values

![[Skew Join.png]]

## Related
- [[Parallel Query Execution]] — architecture, partitioning strategies, and partitioned selection/aggregation
- [[Main Memory Join Algorithms]] — the local join algorithms that run within each node
- [[External Memory Algorithms#GRACE Join (Partitioned Hash Join)]] — the single-node partitioned hash join
- [[Physical Algorithms and Pipelining]] — overview of physical operator classification
- [[Cardinality Estimation]] — skew directly affects cardinality estimates
- [[CSE344/SQL/Joins|Joins]] — the SQL surface syntax compiled into these joins
