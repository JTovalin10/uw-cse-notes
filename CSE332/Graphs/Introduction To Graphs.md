# CSE 332: Introduction to Graphs

A graph is a fundamental data structure used to represent relationships between entities. 

## Definitions
* **[[Graph]]**: Defined as $G = (V, E)$ where $V$ is a set of vertices (nodes) and $E$ is a set of edges.
* **[[Undirected Graph]]**: Edges have no direction. If $(u, v) \in E$, then $(v, u) \in E$.
* **[[Directed Graph]]**: Edges have a direction. $(u, v)$ means an edge from $u$ to $v$.
* **[[Simple Graph]]**: A graph with no self-edges (loops) and no duplicate edges between the same pair of nodes.
* **[[Weighted Graph]]**: Edges have an associated cost or weight, denoted as $w(e)$.

## Graph Terminology
* **[[Adjacent]]** / **[[Neighbors]]**: Nodes are adjacent if they share an edge.
* **[[Degree]]**: The number of edges "touching" a vertex in an undirected graph.
* **[[Indegree]]**: In a directed graph, the number of incoming edges to a vertex.
* **[[Outdegree]]**: In a directed graph, the number of outgoing edges from a vertex.
* **[[Complete Graph]]**: A graph where there is an edge between every pair of nodes.
* **[[Path]]**: A sequence of nodes $(v_1, v_2, \dots, v_k)$ such that $\forall 1 \le i \le k-1$, $(v_i, v_{i+1}) \in E$.
* **[[Simple Path]]**: A path in which each node appears at most once.
* **[[Cycle]]**: A path which starts and ends at the same node.
* **[[Connected Graph]]**: An undirected graph where there is a path between any pair of nodes.
* **[[Strongly Connected Graph]]**: A directed graph where there is a path from any node to any other node.
* **[[Weakly Connected Graph]]**: A directed graph where there is a path between any pair of nodes if we ignore the direction of the edges.

## Graph Properties
* **[[Tree]]**: An undirected, connected graph with no cycles (it is acyclic).
* **[[Graph Density]]**: 
  * The maximum number of edges in a simple graph is $\Theta(|V|^2)$.
  * **[[Dense Graph]]**: $|E| \in \Theta(|V|^2)$.
  * **[[Sparse Graph]]**: $|E| \in \Theta(|V|)$.

## Related
* [[Graph Data Structures]]
* [[Breadth First Search]]
* [[Depth First Search]]