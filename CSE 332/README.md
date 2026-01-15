# CSE 332 - Data Structures and Parallelism

## Course Overview

> *Covers abstract data types and structures including dictionaries, balanced trees, hash tables, priority queues, and graphs; sorting; asymptotic analysis; fundamental graph algorithms including graph search, shortest path, and minimum spanning trees; multithreading and parallel algorithms; P and NP complexity classes.*

CSE 332 builds on introductory data structures knowledge to explore more sophisticated structures, algorithm analysis, and parallel computing. The course emphasizes both theoretical understanding and practical implementation.

**Key Goals:**
- Master advanced data structures and their trade-offs
- Analyze algorithm efficiency using asymptotic notation
- Implement and apply fundamental graph algorithms
- Understand parallel and concurrent programming
- Recognize computational complexity boundaries (P vs NP)

---

## Topics Covered

### Abstract Data Types (ADTs)

An ADT is a mathematical description of a data type that specifies behavior without dictating implementation.

**Key ADTs in this course:**
- **Dictionary/Map**: Key-value storage with lookup, insert, delete
- **Priority Queue**: Access to minimum/maximum element efficiently
- **Set**: Collection with membership testing
- **Graph**: Vertices and edges representing relationships

**Writing ADT Implementations:**
- High-level description of operations
- Specify error conditions with `raise`
- Consider multiple backing structures (array vs linked list)
- Justify design choices

---

### Data Structures

#### Trees
- **Binary Search Trees (BST)**: O(log n) average, O(n) worst case
- **AVL Trees**: Self-balancing BST with height balance property
- **B-Trees**: Balanced trees optimized for disk access

#### Hash Tables
- Hash functions and collision resolution
- Separate chaining vs open addressing
- Load factor and rehashing
- Average O(1) operations

#### Heaps & Priority Queues
- Binary heaps (min-heap, max-heap)
- Heap operations: insert, deleteMin, buildHeap
- Array representation
- Heap sort

#### Graphs
- Representations: adjacency list vs adjacency matrix
- Directed vs undirected graphs
- Weighted graphs

---

### Asymptotic Analysis

Analyzing algorithm efficiency as input size grows.

#### Big-O Formal Definition
For functions f: ℕ → ℝ and g: ℕ → ℝ:

**f(n) ∈ O(g(n))** means there exist positive constants c and n₀ such that:
- f(n) ≤ c · g(n) for all n ≥ n₀

**Intuition:** Big-O gives an upper bound on growth rate.

#### Common Complexity Classes
| Notation | Name | Example |
|----------|------|---------|
| O(1) | Constant | Array access |
| O(log n) | Logarithmic | Binary search |
| O(n) | Linear | Linear search |
| O(n log n) | Linearithmic | Merge sort |
| O(n²) | Quadratic | Nested loops |
| O(2ⁿ) | Exponential | Subset enumeration |

#### Other Notations
- **Ω (Big-Omega)**: Lower bound
- **Θ (Big-Theta)**: Tight bound (both upper and lower)
- **o (Little-o)**: Strict upper bound
- **ω (Little-omega)**: Strict lower bound

---

### Sorting Algorithms

| Algorithm | Best | Average | Worst | Space | Stable |
|-----------|------|---------|-------|-------|--------|
| Insertion Sort | O(n) | O(n²) | O(n²) | O(1) | Yes |
| Merge Sort | O(n log n) | O(n log n) | O(n log n) | O(n) | Yes |
| Quick Sort | O(n log n) | O(n log n) | O(n²) | O(log n) | No |
| Heap Sort | O(n log n) | O(n log n) | O(n log n) | O(1) | No |
| Radix Sort | O(nk) | O(nk) | O(nk) | O(n+k) | Yes |

---

### Graph Algorithms

#### Graph Traversal
- **Breadth-First Search (BFS)**: Level-order traversal, shortest path in unweighted graphs
- **Depth-First Search (DFS)**: Explores as far as possible before backtracking

#### Shortest Path
- **Dijkstra's Algorithm**: Single-source shortest path (non-negative weights)
- **Bellman-Ford**: Handles negative weights, detects negative cycles
- **Floyd-Warshall**: All-pairs shortest path

#### Minimum Spanning Trees
- **Prim's Algorithm**: Grows MST from a starting vertex
- **Kruskal's Algorithm**: Adds edges in sorted order, uses union-find

#### Other Graph Algorithms
- Topological sort (DAGs)
- Connected components
- Cycle detection

---

### Parallelism and Concurrency

#### Multithreading Concepts
- Threads vs processes
- Shared memory model
- Race conditions and synchronization

#### Parallel Algorithms
- Fork-join parallelism
- Parallel prefix (scan)
- Parallel sorting (parallel merge sort)
- Work and span analysis

#### Synchronization
- Locks and mutexes
- Deadlock, livelock, starvation
- Thread-safe data structures

#### Analysis
- **Work**: Total operations (sequential time)
- **Span**: Critical path length (parallel time with infinite processors)
- **Parallelism**: Work / Span ratio

---

### Complexity Theory (P and NP)

#### Complexity Classes
- **P**: Problems solvable in polynomial time
- **NP**: Problems verifiable in polynomial time
- **NP-Complete**: Hardest problems in NP
- **NP-Hard**: At least as hard as NP-Complete

#### Key Concepts
- Decision problems
- Polynomial-time reductions
- The P = NP? question
- Examples of NP-Complete problems (SAT, Traveling Salesman, etc.)

---

## Folder Structure

```
CSE 332/
├── ADT and Design/
│   ├── Abstract Data Type (ADT).md
│   └── Writing the implementation of a DS.md
├── Complexity Analysis/
│   ├── asymptotic analysis.md
│   └── Big Oh formal definition.md
├── Definitions/
└── Screenshots/
```

---

## Key Takeaways

1. **Choose the right data structure**: Different structures have different trade-offs for different operations
2. **Analyze before optimizing**: Use asymptotic analysis to understand bottlenecks
3. **Graphs are everywhere**: Many real-world problems reduce to graph problems
4. **Parallelism requires care**: Concurrency bugs are subtle and hard to debug
5. **Know your limits**: Some problems are inherently hard (NP-Complete)
