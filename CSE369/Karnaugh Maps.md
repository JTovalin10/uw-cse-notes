# Course: Karnaugh Maps

**Karnaugh Maps** (K-maps) are a graphical method used to simplify Boolean algebra expressions. They provide a visual way to find the minimum Sum-of-Products (SOP) or Product-of-Sums (POS) forms without using complex algebraic identities.

## Structure
A K-map is a grid where each cell represents a minterm of the Boolean function.
- The cells are ordered using **Gray Code** (e.g., 00, 01, 11, 10) so that adjacent cells differ by only one bit.
- This adjacency allows for the elimination of variables using the identity $XY + X\bar{Y} = X$.

## Simplification Process
1. **Map the Truth Table**: Place a '1' in the K-map for every minterm where the output is high.
2. **Group the 1s**: Draw loops around groups of 1s.
   - Groups must be powers of 2 (1, 2, 4, 8, ...).
   - Groups must be rectangular.
   - Groups can wrap around the edges of the map.
   - Groups should be as large as possible.
3. **Write the Simplified Expression**: For each group, identify which variables remain constant. If a variable changes (e.g., $A$ is 0 in one cell and 1 in another within the same group), it is eliminated.

### Formal Definition
A diagrammatic method for reducing Boolean expressions to their simplest form by exploiting the adjacency of minterms in $n$-dimensional space, projected onto a 2D grid using Gray code.

### Simplified Explanation
It's a way to find patterns in a truth table to see which inputs don't actually matter for the output, allowing you to use fewer gates.

## Related
- [[CSE369/Combinational Logic|Combinational Logic]]
- [[CSE369/Building Blocks|Building Blocks]]
