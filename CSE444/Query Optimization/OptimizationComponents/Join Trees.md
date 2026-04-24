# CSE444: Join Trees

A **join tree** is a representation of the order in which relations are joined in a query plan. The shape of the tree significantly impacts the search space complexity and the execution efficiency.

## Types of Join Trees

### Bushy Trees
In a **Bushy Tree**, both children of a join node can be intermediate join results. This is the most general form and represents the largest search space.
![[CSE444/Screenshots/Bushy Join Tree.png]]

### Linear Trees (Zig-Zag)
In a **Linear Tree**, at least one child of every join node must be a base relation.
![[CSE444/Screenshots/Linear Join Tree.png]]

#### Left-Deep Join Trees
A specific type of linear tree where the **right child** of every join node is always a base relation.
- **Advantages**:
  - Works well with common join algorithms like Nested-Loops and Hash Join.
  - Facilitates **pipelining**: the intermediate result of one join can be streamed directly into the next join without being materialized to disk.
![[CSE444/Screenshots/Left Deep Join Tree.png]]

#### Right-Deep Join Trees
A type of linear tree where the **left child** of every join node is always a base relation.
![[CSE444/Screenshots/Right Deep Join Tree.png]]

## Related
- [[CSE444/Query Optimization/OptimizationComponents/Search Space|Search Space Pruning]]
- [[CSE444/Query Optimization/OptimizationComponents/Dynamic Programming|Dynamic Programming]]
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]]
