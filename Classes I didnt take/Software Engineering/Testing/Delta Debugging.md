# CSE 403: Delta Debugging

**Delta debugging** is an algorithm that automatically minimizes a failing test case to the smallest possible input that still reproduces the failure. It transforms a large, unwieldy bug report into a concise, reproducible minimal case, dramatically reducing the manual effort needed to understand and fix a defect. Delta debugging is a form of dynamic analysis — see [[Static and Dynamic Analysis]] for the broader dynamic vs. static analysis trade-off.

## Motivation

A large HTML file — potentially thousands of lines — crashes Mozilla Firefox. Manually identifying which part of the file actually triggers the crash is tedious and error-prone. The engineer would have to repeatedly delete sections, re-run the browser, and observe whether the crash persists. The minimal crashing input turns out to be just `<SELECT>`. Delta debugging finds this automatically.

This motivating example illustrates the general problem: given a large, complex failing input, find the smallest subset that still fails. The same technique applies to any structured input — source files, command sequences, lists of configuration flags, sequences of commits, or DOM trees.

## Problem Model

Delta debugging treats the test case as an ordered sequence of **deltas**. A delta is the atomic unit of the input — a line, a character, a commit, a DOM node, or any other granular element depending on the domain.

Formally:

- Let $c_x$ be the original failing configuration (a sequence of $n$ deltas).
- Let $\text{test}(c)$ return $\text{FAIL}$ or $\text{PASS}$ for any subset $c \subseteq c_x$.
- We know $\text{test}(c_x) = \text{FAIL}$ (the original input fails).
- We assume $\text{test}(\emptyset) = \text{PASS}$ (the empty input does not crash).
- **Goal**: find the smallest $c' \subseteq c_x$ such that $\text{test}(c') = \text{FAIL}$.

## Happy Path: Binary Search

In the ideal case, the failure is caused by a single contiguous group of deltas. Delta debugging exploits this by splitting the input in half and testing each half independently.

1. Split $c_x$ into two halves $c_1$ and $c_2$.
2. Test $c_1$. If $\text{test}(c_1) = \text{FAIL}$, recurse on $c_1$.
3. Otherwise test $c_2$. If $\text{test}(c_2) = \text{FAIL}$, recurse on $c_2$.
4. Repeat until a single delta remains.

This is binary search over the input space, and achieves $O(\log n)$ test invocations in the best case. The trouble arises when neither half alone fails — meaning the failure requires the simultaneous presence of deltas from both halves.

## The Not-So-Happy Path

When the bug depends on multiple non-contiguous deltas being present together, testing individual halves will both return $\text{PASS}$, and simple binary search gets stuck. The `ddmin` algorithm generalizes binary search to handle this case.

## The `ddmin` Algorithm

`ddmin` operates by progressively increasing the granularity of the partition. Instead of only testing two halves, it tries $n$ chunks of roughly equal size, attempting to reduce the failing input by testing each chunk and its complement.

### Formal Definition

Let $c_x$ be the current failing input and $n$ be the current granularity (number of chunks).

$$\text{ddmin}(c_x) = \text{ddmin}_2(c_x, 2)$$

At each recursive call $\text{ddmin}_2(c_x, n)$:

Partition $c_x$ into $n$ chunks $c_1, c_2, \ldots, c_n$ of approximately equal size. Apply the following four cases **in order** at each step:

1. **Reduce to subset**: if $\exists i$ such that $\text{test}(c_i) = \text{FAIL}$, then $\text{ddmin}_2(c_i, 2)$
2. **Reduce to complement**: if $\exists i$ such that $\text{test}(c_x \setminus c_i) = \text{FAIL}$, then $\text{ddmin}_2(c_x \setminus c_i, \max(n-1, 2))$
3. **Increase granularity**: if neither (1) nor (2) succeeded and $n < |c_x|$, then $\text{ddmin}_2(c_x, \min(2n, |c_x|))$
4. **Done**: if $n \geq |c_x|$, return $c_x$ (result is 1-minimal)

### Simplified Explanation

Start with 2 chunks. Try each chunk alone — if one fails, you found a smaller failing input; shrink it and restart at granularity 2. If a chunk alone doesn't fail, try removing that chunk (the complement) — if the rest still fails, shrink to the complement and reduce granularity by 1. If nothing works at this granularity, double the number of chunks and try again with finer slices. Keep going until the chunks are individual deltas — at that point, no single delta can be removed without the test passing, so you've reached a 1-minimal result.

### Walkthrough of the Four Cases

The four cases are tried in strict priority order at each step. Understanding why each exists clarifies the algorithm's logic:

**Case 1 — Reduce to subset**: One chunk alone is sufficient to reproduce the failure. This is the "happy path" within the generalized algorithm. You've identified a strictly smaller failing input. Reset granularity to 2 and recurse on the reduced input — the full doubling process restarts on the smaller problem.

**Case 2 — Reduce to complement**: No single chunk alone causes the failure, but removing one chunk still leaves a failing input. This means the failure can survive without that chunk. Remove it, reduce the problem size, and decrease granularity by 1 (but never below 2) since the partition is now slightly smaller.

**Case 3 — Increase granularity**: Neither reducing to a subset nor to a complement worked at this granularity. The failing deltas are distributed across multiple chunks such that no single chunk or its complement isolates the failure. Double the number of chunks to get finer resolution, then retry. This continues until the granularity equals the input size (each delta is its own chunk).

**Case 4 — Done**: Every individual delta has been considered and no further reduction is possible. The result is **1-minimal**: removing any single remaining delta causes the test to pass.

```mermaid
flowchart TD
    A["Start: ddmin(c_x) = ddmin2(c_x, 2)"] --> B["Partition c_x into n chunks"]
    B --> C{Case (1): test any chunk c_i = FAIL?}
    C -->|Yes| D["Reduce to c_i, reset granularity to 2\nddmin2(c_i, 2)"]
    D --> B
    C -->|No| E{Case (2): test complement c_x minus c_i = FAIL?}
    E -->|Yes| F["Reduce to complement\nddmin2(c_x minus c_i, max(n-1, 2))"]
    F --> B
    E -->|No| G{Case (3): n < size of c_x?}
    G -->|Yes| H["Increase granularity\nddmin2(c_x, min(2n, size of c_x))"]
    H --> B
    G -->|No| I["Case (4): Return c_x\n(1-minimal result)"]
```

## Concrete Example: Mozilla HTML Crash

Starting from an HTML file with thousands of lines (say $n = 4096$ lines):

1. Granularity begins at 2. Two halves are tested.
2. Suppose neither half alone crashes Mozilla. Move to Case 2 (complement testing). Suppose some complement still crashes — remove that chunk.
3. The input shrinks. Restart with granularity 2 on the smaller input.
4. Eventually, after multiple passes, all non-essential markup is stripped. What remains is `<SELECT>`, which individually triggers the parser fault.

The algorithm handles this because at each step it systematically narrows the search: first trying gross reductions, then fine-grained ones, and always maintaining the invariant that the current $c_x$ is a failing input.

## Properties

### 1-Minimality

The result of `ddmin` is **1-minimal**: no single delta can be removed from the output while preserving the failure. This is not the same as **global minimality** — there may exist a strictly smaller failing subset reachable by removing multiple deltas simultaneously, but ddmin does not guarantee finding it. Global minimality is computationally intractable in general.

### Complexity

| Case | Complexity |
|---|---|
| Best case (binary search succeeds) | $O(\log n)$ |
| Worst case (granularity doubles repeatedly, full complement scans) | $O(n^2)$ |

The worst case arises when the failure requires many scattered deltas simultaneously and no intermediate reduction succeeds until fine-grained partitioning reaches individual elements.

### Assumptions

**Monotonicity**: if $c' \subseteq c$ and $\text{test}(c) = \text{FAIL}$, it is not required that $\text{test}(c') = \text{FAIL}$. Delta debugging does not assume monotonicity in the strong sense — it handles the case where subsets pass. However, the algorithm implicitly assumes that the test outcome is stable under the same input (determinism).

**Determinism**: given the same input $c$, $\text{test}(c)$ always returns the same result. Non-deterministic bugs (race conditions, timing-dependent failures) can cause false $\text{PASS}$ results during reduction, leading to an over-reduced or incorrect minimal case.

**Applicability**: the input must be decomposable into an ordered sequence of discrete deltas. This is satisfied by: lines of source code, characters in a string, commits in a repository history, nodes in a DOM tree, SQL statements in a transaction log, etc.

## Applicability Beyond Files

Delta debugging applies to any domain where test cases are sequences:

- **Git bisect**: find the commit that introduced a regression. Deltas are commits. `ddmin` reduces to binary search (monotonicity holds — if commit $k$ introduced the bug, all commits after it fail).
- **Compiler test reduction**: minimize a crashing C program to a small snippet.
- **Configuration minimization**: reduce a large set of configuration flags to the minimal combination that triggers a failure.
- **Network packet traces**: isolate the minimal packet sequence that exposes a protocol bug.

## Related

- [[Mutation Testing]] — complementary technique measuring test suite quality rather than minimizing inputs
- [[Testing Fundamentals]] — fault/error/failure model and regression testing context
- [[Static and Dynamic Analysis]] — delta debugging as an instance of dynamic analysis
- [[Program Analysis Overview]] — broader program analysis landscape including debugging

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Delta debugging | Automated test case reduction / input minimization |
| Delta | Atomic input element / test case component |
| `test(c) = FAIL` | Oracle / failure predicate |
| 1-minimal | Locally minimal failing input |
| `ddmin` algorithm | Zeller's delta debugging minimization (published as ddmin in 2002) |
| Granularity | Partition resolution / chunk size |
| Complement | Input remainder after removing a chunk |
| Monotonicity assumption | Superset-closed failure property |
