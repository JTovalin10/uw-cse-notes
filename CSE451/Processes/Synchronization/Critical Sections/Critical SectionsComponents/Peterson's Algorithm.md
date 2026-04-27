# Peterson's Algorithm

Peterson's Algorithm is a classic software-based solution to the **Critical Section** problem for two processes. It provides a way to ensure mutual exclusion without the need for specialized hardware instructions (like `test-and-set`), assuming atomic memory loads and stores.

## The Code (for Process $i$)

```c
// Process i (other process is j)
flag[i] = true;           // I am interested in entering
turn = j;                 // Give the other process the chance first
while (flag[j] && turn == j) {
    // Busy wait (spin)
}

// CRITICAL SECTION

flag[i] = false;          // I am done
```

## How it Works: The 3 Requirements

Peterson's algorithm is guaranteed to satisfy the three requirements of the critical section problem:

1.  **Mutual Exclusion**: 
    - To enter the critical section, process $i$ must have `flag[i] == true` AND either `flag[j] == false` or `turn == i`.
    - If both processes are in the critical section, then `flag[0]` and `flag[1]` must both be true.
    - However, `turn` can only be 0 or 1 at any given moment. Therefore, only one process could have passed the `while` loop condition.

2.  **Progress**:
    - If no process is in the critical section and a process wants to enter, it will set its flag and `turn`.
    - If only one process is interested, `flag[j]` will be false, and it will enter immediately.
    - If both are interested, the one that set `turn` *last* will wait, while the other enters.

3.  **Bounded Waiting**:
    - A process $i$ will wait at most one entry by process $j$. 
    - Once process $j$ leaves the critical section, it sets `flag[j] = false`, allowing process $i$ to enter. 
    - If process $j$ tries to re-enter immediately, it will set `turn = i`, ensuring process $i$ gets its turn.

## Limitations
- **Busy Waiting**: Like all spinlocks, it wastes CPU cycles while waiting.
- **Two-Process Limit**: The basic version only works for two processes.
- **Memory Reordering**: On modern CPUs with out-of-order execution, Peterson's algorithm requires **Memory Barriers** (fences) to ensure the `flag` and `turn` updates are visible in the correct order.
