# CSE 332: Kruskal's Algorithm

**Kruskal's Algorithm** finds a Minimum Spanning Tree (MST) for a connected weighted undirected graph.

## Idea
Instead of growing a single connected tree like Prim's, Kruskal's considers all edges in the entire graph simultaneously. It considers them in strictly increasing order of weight. It greedily adds the lowest-weight edge to the MST *as long as it does not create a cycle*.

## Algorithm
1. Start with an empty set of edges $A$.
2. Sort all edges in $E$ by weight from smallest to largest.
3. For each edge in the sorted list:
   * If adding the edge to $A$ does **not** create a cycle, add it.
   * Otherwise, safely discard it.

To efficiently check for cycles when adding edges, Kruskal's relies heavily on a **Disjoint-Set (Union-Find)** data structure. Each node starts in its own isolated set. When an edge $(u, v)$ is evaluated, we check if $u$ and $v$ are already in the same set (which would mean a path already exists between them, and adding this edge would form a cycle). If they are in different sets, we add the edge to our MST and `union` their respective sets.

## Complexity
* **Time Complexity**: $O(|E| \log |V|)$.
  * Sorting the edges takes $O(|E| \log |E|)$, which is equivalent to $O(|E| \log |V|)$ because $|E| \le |V|^2 \implies \log(|E|) \le 2\log(|V|)$.
  * The Disjoint-Set operations (Find and Union) are extremely fast, essentially running in amortized constant time, so the initial edge sorting step asymptotically dominates the runtime.

## Proof Sketch
It's sufficient to show that Kruskal's follows the template of the General MST Algorithm. For every edge chosen, we can show it is the least-weight edge which crosses some valid cut that respects all already-chosen edges. Since Kruskal's sorts by weight, the edge $e$ it picks is guaranteed to be minimal across the cut isolating its two components.

## Related
* [[Minimum Spanning Trees]]
* [[Prims Algorithm]]