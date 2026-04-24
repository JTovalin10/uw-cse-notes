# CSE 332: Prim's Algorithm

**Prim's Algorithm** finds a Minimum Spanning Tree (MST) for a connected weighted undirected graph.

## Idea
Prim's algorithm builds a single tree $A$. It starts from an arbitrary root node. At each step, it looks at all the edges connecting the current tree $A$ to nodes not yet in $A$, and greedily adds the minimum-weight edge to $A$. This perfectly implements the [[Cut Theorem]] where the cut is implicitly defined as (Nodes currently in $A$, Nodes not in $A$).

## Algorithm
Similar to Dijkstra's, we use a **Priority Queue** to pick the next closest node to add to our growing spanning tree.

```java
Set<Edge> prims(Graph graph, Node start) {
    // Initialize distances to infinity
    Map<Node, Integer> distance = new HashMap<>();
    Map<Node, Edge> edgeTo = new HashMap<>();
    for (Node v : graph.getVertices()) distance.put(v, Integer.MAX_VALUE);
    
    distance.put(start, 0);
    MinHeap<Node> pq = new MinHeap<>();
    pq.insert(start, 0);
    
    Set<Edge> mstEdges = new HashSet<>();
    
    while (!pq.isEmpty()) {
        Node curr = pq.extractMin();
        
        if (curr.isMarked("done")) continue;
        mark curr as "done";
        
        // Add the edge that brought us here to the actual MST
        if (edgeTo.containsKey(curr)) {
            mstEdges.add(edgeTo.get(curr));
        }
        
        for (Edge e : graph.getNeighbors(curr)) {
            Node v = e.target;
            if (!v.isMarked("done")) {
                // Note: we care about the edge weight itself, not total distance from start
                if (e.weight < distance.get(v)) {
                    distance.put(v, e.weight);
                    edgeTo.put(v, e);
                    pq.insert(v, e.weight); // or decreaseKey(v, e.weight)
                }
            }
        }
    }
    return mstEdges;
}
```

## Complexity
* **Time Complexity**: $\Theta(|E| \log |V|)$. We process each edge and perform Priority Queue operations. This is identical to Dijkstra's runtime. If we use duplicates in the PQ instead of `decreaseKey` (since Java's `PriorityQueue` lacks it), the worst-case asymptotic runtime does not change because $E \le V^2$ makes $O(|E| \log |E|)$ equal to $O(|E| \log |V|)$.

## Proof Sketch
By Structural Induction: Suppose we have an arbitrary set of edges $A$ that Prim's has already selected to include in the MST. $e=(E,G)$ is the edge it selects to add next. We can cut the graph into 2 disjoint sets: Nodes removed from priority queue, and All other nodes. $e$ is the minimum cost edge that crosses this cut, so by the Cut Theorem, Prim's only selects valid MST edges!

## Related
* [[Minimum Spanning Trees]]
* [[Dijkstras Algorithm]]
* [[Kruskals Algorithm]]