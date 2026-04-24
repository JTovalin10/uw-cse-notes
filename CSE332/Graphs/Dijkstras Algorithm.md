# CSE 332: Dijkstra's Algorithm

**[[Dijkstra's Algorithm]]** finds the single-source shortest path in a weighted graph. Given a graph $G=(V, E)$ and a start node $s$, it finds the least-weight path from $s \to v$ to every other node.

**Critical Assumption**: The graph contains **no negative edge weights**.

## Idea
When a node is the closest "not-done" thing to the start, we have found its absolute shortest path. We extract the node from a Priority Queue, mark it as "done", and update the distances to its unvisited neighbors if we found a better path through this newly-done node.

## Algorithm
```java
Map<Node, Integer> dijkstra(Graph graph, Node start) {
    // Initialize distances to infinity
    Map<Node, Integer> distances = new HashMap<>();
    for (Node v : graph.getVertices()) distances.put(v, Integer.MAX_VALUE);
    distances.put(start, 0);
    
    // MinHeap prioritized by distance from start
    MinHeap<Node> pq = new MinHeap<>();
    pq.insert(start, 0);
    
    while (!pq.isEmpty()) {
        Node curr = pq.extractMin();
        
        if (curr.isMarked("done")) continue;
        mark curr as "done";
        
        for (Edge e : graph.getNeighbors(curr)) {
            Node v = e.target;
            int weight = e.weight;
            
            if (!v.isMarked("done")) {
                int newDist = distances.get(curr) + weight;
                if (newDist < distances.get(v)) {
                    distances.put(v, newDist);
                    pq.insert(v, newDist); // Or decreaseKey(v, newDist) if supported
                }
            }
        }
    }
    return distances;
}
```

## Running Time
* **Priority Queue Operations**: We insert nodes into the priority queue and potentially decrease their key (or add duplicates if `decreaseKey` isn't supported, like in Java's `PriorityQueue`).
* **Overall Time Complexity**: $\Theta(|E| \log |V|)$
    * We perform at most $|E|$ inserts / decreaseKeys. Each PQ operation takes $O(\log |V|)$ time.

## Proof of Correctness
Claim: When a node is removed from the priority queue, its distance is that of the true shortest path.
* **Proof by Induction** over the number of completed nodes.
* **Base Case**: Only the start node removed. It is indeed 0 away from itself.
* **Inductive Step**: Suppose $a$ is the next node removed from the queue. Consider any other incomplete node $b$ that is 1 edge away from a complete node. $a$ is the closest node that is one away from a complete node. No path from $b$ to $a$ can have negative weight. Thus no path that includes $b$ can be a shorter path to $a$. Therefore the shortest path to $a$ must use only complete nodes, and therefore we have found it already!

## Negative Edge Weights
Dijkstra's algorithm **fails** if there are negative edge weights. If a graph has negative edges, a node previously marked "done" could suddenly have a shorter path discovered via a negative edge loop, violating the algorithm's foundational invariant.

## Related
* [[Breadth First Search]]
* [[Minimum Spanning Trees]]
* [[CSE461/Routing Layer/Routing Layer - Intradomain Routing (DV and LS)|Routing: Intradomain Routing (DV and LS)]]
* [[CSE461/Routing Layer/Routing Layer - Open Shortest Path First (OSPF)|Routing: OSPF]]