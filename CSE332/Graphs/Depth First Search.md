# CSE 332: Depth-First Search

**[[Depth-First Search]] (DFS)** is a graph traversal algorithm that explores as deep as possible along each branch before backtracking.

## Behavior
Start with a node $s$, visit one neighbor of $s$, then visit all nodes reachable from that neighbor before moving on to the second neighbor of $s$.

## Algorithm
DFS can be implemented iteratively using a **Stack** or recursively (which implicitly uses the system call stack).

### Recursive Approach
```java
public void dfsRecursive(Graph graph, Node curr, Set<Node> visited) {
    visited.add(curr);
    // Process curr

    for (Node neighbor : graph.getNeighbors(curr)) {
        if (!visited.contains(neighbor)) {
            dfsRecursive(graph, neighbor, visited);
        }
    }
}
```

### Iterative Approach (Stack-based)
```java
public void dfsIterative(Graph graph, Node startNode) {
    Stack<Node> stack = new Stack<>();
    Set<Node> visited = new HashSet<>();

    stack.push(startNode);

    while (!stack.isEmpty()) {
        Node curr = stack.pop();

        if (!visited.contains(curr)) {
            visited.add(curr);
            // Process curr

            for (Node neighbor : graph.getNeighbors(curr)) {
                if (!visited.contains(neighbor)) {
                    stack.push(neighbor);
                }
            }
        }
    }
}
```

## Applications
DFS is commonly used for:
* Finding if a graph is connected.
* Finding paths between nodes.
* **[[Cycle Detection]]**: If we encounter a node that is currently "in progress" (visited but not yet "done"), we have found a back edge, which definitively indicates a cycle.
* **[[Topological Sort]]**.

## Edge Classification in DFS
By keeping track of "visited" (discovery) and "done" (finish) times, edges can be classified:
1. **[[Tree Edge]]**: $(a, b)$ was followed when pushing (i.e., $b$ was unvisited when we were at $a$).
2. **[[Back Edge]]**: $(a, b)$ goes to an "ancestor". $a$ and $b$ are visited but not done when we see $(a, b)$. This indicates a **cycle**!
3. **[[Forward Edge]]**: $(a, b)$ goes to a "descendant". $b$ was visited and done between when $a$ was visited and done.
4. **[[Cross Edge]]**: $(a, b)$ goes to a node that doesn't connect to $a$ directly as an ancestor or descendant.

## Cycle Detection Logic
To look for a cycle, we search for a back edge.
```java
boolean hasCycle(Graph graph, Node curr) {
    mark curr as "visited";
    boolean cycleFound = false;
    
    for (Node v : graph.getNeighbors(curr)) {
        if (v.isMarked("visited") && !v.isMarked("done")) {
            cycleFound = true; // Found a back edge!
        }
        if (!v.isMarked("visited") && !cycleFound) {
            cycleFound = hasCycle(graph, v);
        }
    }
    mark curr as "done";
    return cycleFound;
}
```

## Complexity
* **Time Complexity**: $\Theta(|V| + |E|)$
* **Space Complexity**: $O(|V|)$ for the recursion call stack and visited tracking arrays.

## Related
* [[Breadth First Search]]
* [[Topological Sort]]