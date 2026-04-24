# CSE 332: Graph Data Structures

To implement the Graph ADT, we need to efficiently support operations like `addEdge`, `removeEdge`, `exists`, and `getNeighbors`. 

Let $|V| = n$ and $|E| = m$.

## Adjacency List
An array of size $n$, where each index $i$ stores a list (or linked list) of all neighbors of vertex $i$.

* **Space Complexity**: $\Theta(n + m)$
* **Add Edge $(v, w)$**: $\Theta(\deg(v))$ (or $\Theta(1)$ if appending to a linked list without checking for duplicates)
* **Remove Edge $(v, w)$**: $\Theta(\deg(v))$
* **Check if Edge $(v, w)$ exists**: $\Theta(\deg(v))$
* **Get Neighbors**: $\Theta(\deg(v))$ to traverse the list.

**Pros**: Adjacency lists are much more common in practice because most real-world graphs are sparse ($|E| \ll |V|^2$), meaning it saves a significant amount of memory. Iterating over a node's neighbors is extremely fast.

## Adjacency Matrix
An $n \times n$ matrix (2D array) where the value at `matrix[i][j]` represents the presence (or weight) of an edge from node $i$ to node $j$.

* **Space Complexity**: $\Theta(n^2)$
* **Add Edge $(v, w)$**: $\Theta(1)$
* **Remove Edge $(v, w)$**: $\Theta(1)$
* **Check if Edge $(v, w)$ exists**: $\Theta(1)$
* **Get Neighbors**: $\Theta(n)$ (must scan the entire row to find non-zero entries)

**Pros**: Best when the graph is very dense ($|E| \approx |V|^2$) or when checking for edge existence in constant time is a critical operation for the application.

## Related
* [[Introduction To Graphs]]