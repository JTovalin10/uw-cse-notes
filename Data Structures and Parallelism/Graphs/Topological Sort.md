# CSE 332: Topological Sort

**[[Topological Sort]]** of a directed acyclic graph (DAG) $G = (V, E)$ is a permutation of $V$ such that if there is an edge $(u, v) \in E$, then $u$ appears before $v$ in the permutation.

## Finding a Topological Sort
Topological sort can be elegantly implemented using a **[[Depth First Search]]**.

**Idea**: List the nodes in the reverse order of their DFS "done" time. When a node is marked "done" in DFS, all its descendants have already been recursively processed and marked "done". By adding a node to a list right when it finishes, we get the exact reverse topological order. Reversing this list yields the final sort.

## Algorithm
```java
List<Node> topSort(Graph graph) {
    List<Node> doneList = new ArrayList<>();
    
    for (Node v : graph.getVertices()) {
        if (!v.isMarked("visited")) {
            finishTime(graph, v, doneList);
        }
    }
    
    Collections.reverse(doneList);
    return doneList;
}

void finishTime(Graph graph, Node curr, List<Node> doneList) {
    mark curr as "visited";
    for (Node v : graph.getNeighbors(curr)) {
        if (!v.isMarked("visited")) {
            finishTime(graph, v, doneList);
        }
    }
    doneList.add(curr); // Add to list when "done"
}
```

## Requirements
* The graph must be **directed**.
* The graph must **not contain any cycles** (it must be a DAG). If a cycle exists, a valid topological sort is mathematically impossible.

## Complexity
* **Time Complexity**: $\Theta(|V| + |E|)$ (since it's fundamentally just a complete DFS pass)

## Related
* [[Depth First Search]]