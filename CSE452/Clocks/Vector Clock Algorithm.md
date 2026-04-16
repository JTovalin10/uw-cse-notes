# CSE452: Vector Clock Algorithm

**Vector clocks** extend [[CSE452/Clocks/Logical Clocks|Lamport clocks]] to capture causality in both directions. Unlike Lamport clocks, vector clocks allow you to definitively determine whether two events are causally related or concurrent.

## Key Idea

Each node maintains a **vector** (list of numbers) of length equal to the number of nodes in the system. The $i$th component represents the highest clock value the node has heard about for node $i$.

**Claim**: $e_1$ happens-before $e_2$ **if and only if** $VC(e_1) \leq VC(e_2)$ (component-wise)

This biconditional is stronger than the Lamport clock condition, which only holds in one direction.

## Algorithm

1. **Initialize**: every node starts with a vector of zeros, except its own component is set to 1
   - Node $a$: $[1, 0, 0, 0]$
   - Node $b$: $[0, 1, 0, 0]$
   - Node $c$: $[0, 0, 1, 0]$
   - Node $d$: $[0, 0, 0, 1]$
2. **Send**: include the current vector clock in every outgoing message
3. **Receive**: take the component-wise max of the received vector and the local vector, then increment the receiver's own component by 1
   - Example: $\max([1,0,0,0],\ [0,1,0,0]) + 1_b = [1, 2, 0, 0]$
4. **Local step**: increment only the node's own component by 1

## Comparison with Lamport Clocks

| Property | Lamport Clock | Vector Clock |
|---|---|---|
| Data structure | Single integer | Vector of integers |
| $e_1 \rightarrow e_2$ implies | $C(e_1) < C(e_2)$ | $VC(e_1) < VC(e_2)$ |
| $C(e_1) < C(e_2)$ implies | Nothing certain | $e_1 \rightarrow e_2$ |
| Can detect concurrency | No | Yes |

## Related

- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — the simpler single-counter version
- [[CSE452/Clocks/Lamport Clock Algorithm|Lamport Clock Algorithm]] — Lamport's original algorithm
- [[CSE452/Clocks/Virtual + Vector Clocks|Virtual and Vector Clocks]] — overview and space-time diagrams
