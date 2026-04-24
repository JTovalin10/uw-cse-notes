# CSE 332: Breadth-First Search

**[[Breadth-First Search]] (BFS)** is a graph traversal algorithm that explores nodes level-by-level, expanding outwards from a starting node $s$.

## Behavior
BFS starts with node $s$, visits all neighbors of $s$, then visits all neighbors of neighbors, and so on. It guarantees that it visits every node reachable from $s$ in order of their shortest distance from $s$.

## Algorithm
BFS uses a **Queue** to keep track of nodes to visit next.

```java
public void bfs(Graph graph, Node startNode) {
    Queue<Node> queue = new LinkedList<>();
    Set<Node> visited = new HashSet<>();

    queue.add(startNode);
    visited.add(startNode);

    while (!queue.isEmpty()) {
        Node curr = queue.poll();
        // Process curr (e.g., print it)

        for (Node neighbor : graph.getNeighbors(curr)) {
            if (!visited.contains(neighbor)) {
                visited.add(neighbor);
                queue.add(neighbor);
            }
        }
    }
}
```

## Finding Shortest Paths (Unweighted)
BFS can perfectly compute the shortest path (minimum number of edges) from the start node to all other reachable nodes.

```java
public Map<Node, Integer> findDistances(Graph graph, Node startNode) {
    Queue<Node> queue = new LinkedList<>();
    Map<Node, Integer> distances = new HashMap<>();

    queue.add(startNode);
    distances.put(startNode, 0);

    while (!queue.isEmpty()) {
        Node curr = queue.poll();
        int currDist = distances.get(curr);

        for (Node neighbor : graph.getNeighbors(curr)) {
            if (!distances.containsKey(neighbor)) {
                distances.put(neighbor, currDist + 1);
                queue.add(neighbor);
            }
        }
    }
    return distances;
}
```

## Complexity
* **Time Complexity**: $\Theta(|V| + |E|)$ because every vertex is enqueued/dequeued at most once, and we examine each edge once (in a directed graph) or twice (in an undirected graph).
* **Space Complexity**: $O(|V|)$ for the queue and visited set.

## Related
* [[Depth First Search]]
* [[Dijkstras Algorithm]]