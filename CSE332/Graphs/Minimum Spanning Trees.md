# CSE 332: Minimum Spanning Trees

A **Spanning Tree** of a connected undirected graph $G = (V, E)$ is a subset of edges that connects ("spans") all the nodes in the graph and has no cycles. Any such set of $|V| - 1$ edges forms a valid spanning tree.

A **Minimum Spanning Tree** (MST) is a spanning tree that minimizes the total cost (sum of edge weights):
$$ Cost(T) = \sum_{e \in E_T} w(e) $$

## The Cut Theorem
The correctness of MST algorithms relies mathematically on the **[[Cut Theorem]]**.

* **Cut**: A partition of the nodes $V$ into two disjoint sets, $S$ and $V - S$.
* **Crossing Edge**: An edge $(v_1, v_2) \in E$ crosses a cut if one endpoint is in $S$ and the other is in $V - S$.
* **Respects a Cut**: A set of edges $A$ respects a cut if no edges in $A$ cross the cut.

**Cut Theorem**: If a set of edges $A$ is a subset of a minimum spanning tree $T$, let $(S, V - S)$ be any cut which $A$ respects. Let $e$ be the least-weight edge which crosses the cut. Then $A \cup \{e\}$ is also a subset of a minimum spanning tree.

## General MST Algorithm Template
1. Start with an empty tree $A$.
2. Repeat $|V| - 1$ times:
   * Pick a cut $(S, V - S)$ which $A$ respects (typically done implicitly).
   * Add the min-weight edge which crosses $(S, V - S)$.

## Algorithms
Two famous algorithms efficiently implement this template:
* **[[Prims Algorithm]]**: Greedily grows a single, connected tree outwards from a start node.
* **[[Kruskals Algorithm]]**: Greedily sorts all edges and merges a forest of disconnected trees together.

## Related
* [[Prims Algorithm]]
* [[Kruskals Algorithm]]
* [[Introduction To Graphs]]