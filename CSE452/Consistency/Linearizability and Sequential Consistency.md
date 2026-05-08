# CSE452: Linearizability and Sequential Consistency

These are the two primary "Strong" consistency models for single-object operations. 

## The Hierarchy
Linearizability is **strictly stronger** than sequential consistency. In terms of legal executions:
$$\text{Linearizable} \subset \text{Sequentially Consistent}$$
This means every linearizable execution is sequentially consistent, but the reverse is not true.

## Linearizability
**Linearizability** is the strongest form of consistency for single-object operations. A linearizable data structure behaves as if there is only a single, atomic copy of the data, even if it is replicated across multiple nodes.

### Definition
An execution is **linearizable** if there exists a single total order of all client operations such that:
1. **Correctness**: The responses sent to clients return the same answers as if the operations were executed sequentially in that total order.
2. **Program Order**: The total order respects the local ordering of requests from each individual client.
3. **Real-time Order**: If an operation $A$ completes (receives a response) before operation $B$ begins (is invoked), then $A$ must appear before $B$ in the total order.


> [!IMPORTANT]
> Linearizability is **strictly stronger** than sequential consistency because it requires the system to respect the wall-clock precedence of non-overlapping operations.

### Proving Linearizability
- **Linearization Points**: Identify a specific point in time (the "linearization point") for every operation between its invocation and its response. If all operations appear to occur atomically at their respective points, the system is linearizable.
- **Precedence Graphs**: Construct a directed graph where nodes are operations. Add edges for program order and real-time order. If the graph has a cycle, the execution is **not** linearizable.
- **State Contradiction**: Show that a read returned a value that violates the "most recent write" rule under any valid real-time ordering.

---

## Sequential Consistency
**Sequential Consistency** is a weaker model that respects the order of operations from individual clients but allows the global order to deviate from real-time wall-clock time.

### Definition
An execution is **sequentially consistent** if there exists some total ordering of all client operations such that:
1. **Correctness**: The responses agree with executing the requests in that total order.
2. **Program Order**: The total order is consistent with each individual client's local order of operations.

### Key Difference
Sequential consistency does **not** have a real-time constraint. If Client A finishes a write at 10:00 AM and Client B starts a read at 10:01 AM, sequential consistency *allows* Client B to see the old value, provided there is *some* valid total order (where B's read is placed before A's write) that respects everyone's local program order.

---

## Comparison of Models

| Feature | Linearizability | Sequential Consistency |
| :--- | :--- | :--- |
| **Total Order?** | Yes | Yes |
| **Respects Program Order?** | Yes | Yes |
| **Respects Real-time Order?** | **Yes** | No |
| **Performance** | Lower (Requires high coordination) | Higher (Allows stale reads/asynchrony) |
| **Transactions?** | Single-object only | Single-object only |
| **Transactional Equivalent** | Strict Serializability | Serializability |

---

## Other Consistency Models

![[CSE452/Screenshots/types of consistency.png]]

### [[CSE452/Consistency/Definitions/Strict Consistency|Strict Consistency]]
The theoretical ideal: every read returns the most recent write instantly.
- Requires perfectly synchronized clocks (impossible).
- Upper bound for all other models.

### [[CSE452/Consistency/Definitions/Causal Consistency|Causal Consistency]]
Causal consistency relates operations that are causally linked (ordered by the **Happens-Before** relationship).
- If $W(x)1 \rightarrow W(x)2$, then all nodes must see the write of $1$ before the write of $2$.
- **Concurrent** writes (no causal link) can be seen in different orders by different nodes.
- **Cool Theorem**: Causal consistency is the strongest form of consistency that can be provided in an "always-available" convergent system (one that survives network partitions).

### [[CSE452/Consistency/Definitions/FIFO Consistency|FIFO / PRAM Consistency]]
The system guarantees that writes from a single process are seen by all others in the order they were issued.
- Does **not** track dependencies between different processes.
- Weaker than Causal Consistency.

### [[CSE452/Consistency/Definitions/Processor Consistency|Processor Consistency]]
- **Processor Consistency**: Writes by the same process are seen in order, but writes by different processes can be seen in different orders by different readers.
- **Memory Barrier / Fence**: Primitives used in lower-level programming (see: [[CSE452/Consistency/Memory Consistency|Memory Consistency]]) to enforce ordering.

### [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual Consistency]]
If all writes to the system stop, eventually all processes will read the same value. This is the weakest common model and is used by systems like DNS or Amazon's Dynamo (AP systems).

---

# Examples

## Key-Value Store Scenarios
Initial state: `x = 0`

### 1. Sequential Consistency (but NOT Linearizable)
*   **Client A**: `Write(x, 1)` $\to$ ACK at 10:00 AM.
*   **Client B**: `Read(x)` $\to$ returns `0` at 10:01 AM.
*   **Analysis**: Legal under Sequential Consistency because we can order the operations as `Read_B` then `Write_A`. This respects the local order of each client. It fails Linearizability because 10:01 AM is after 10:00 AM, so the write must be visible.

### 2. Linearizability
*   **Client A**: `Write(x, 1)` $\to$ ACK at 10:00 AM.
*   **Client B**: `Read(x)` $\to$ returns `1` at 10:01 AM.
*   **Analysis**: Legal. The total order matches the wall-clock time: `Write_A` $\to$ `Read_B`.

### 3. Violation of Both (Program Order Failure)
*   **Client A**: `Write(x, 1)`, then `Write(x, 2)`.
*   **Client B**: `Read(x)` returns `2`, then `Read(x)` returns `1`.
*   **Analysis**: Illegal. This violates Client A's program order. There is no total order that can place `2` before `1` while respecting A's sequence.

## The Stale Read Scenario
Suppose a key `x` starts at `0`.
1. **Client A** writes `x = 1` and receives an ACK.
2. **Client B** starts a read later and gets `x = 0`.

- **Is this Linearizable?** No. Operation A finished before B started, so A must be before B. B must see `1`.
- **Is this Sequentially Consistent?** Yes, as long as there's no other operation from B that forces A to be earlier. We can say the total order was `Read_B(x)0 -> Write_A(x)1`. This respects program order for both.

## Causal Consistency Scenario: "The Social Media Thread"
1. **Alice** posts a question: `Write(Post_A, "Lunch?")`.
2. **Bob** reads Alice's post and replies: `Write(Post_B, "Pizza!")`.
- **The Causal Link**: Post B "happens-after" Post A because Bob read A before writing B.
- **Requirement**: Any user who sees Bob's reply **must** also see Alice's question. It is illegal to see "Pizza!" without the context of "Lunch?".
- **Concurrent Events**: If Carol posts `Write(Post_C, "I'm busy")` without reading Alice's or Bob's posts, her post is concurrent. Different users might see Carol's post before or after Alice's, and that is legal.

## Processor Consistency Scenario: "The Parallel Log"
- **Process 1** writes: `W(x)1`, then `W(x)2`.
- **Process 2** writes: `W(y)3`, then `W(y)4`.
- **Observation**:
    - **Reader A** sees: `1, 3, 2, 4`. (Legal: 1 before 2, 3 before 4).
    - **Reader B** sees: `3, 1, 4, 2`. (Legal: 1 before 2, 3 before 4).
- **Analysis**: This is legal under Processor Consistency. Both readers see the writes from each individual process in the correct order, but they don't have to agree on how the two processes' writes were interleaved.

## Eventual Consistency Scenario: "The DNS Update"
1. **Admin** updates `example.com` to point to a new IP `1.2.3.4`.
2. **User A** in Seattle queries DNS and gets the new IP `1.2.3.4`.
3. **User B** in Tokyo queries DNS and gets the old IP `5.6.7.8` because the update hasn't propagated to the Tokyo edge server yet.
- **Convergence**: 24 hours later, after all caches expire, both users see `1.2.3.4`.
- **Analysis**: The system was temporarily inconsistent, but "eventually" converged to the same state.

---

## Related
- [[CSE452/Consistency/Memory Consistency|Memory Consistency]] — how these concepts apply to hardware memory
- [[CSE452/Consistency/CAP Theorem and Partitions|CAP Theorem and Partitions]] — the trade-off between consistency and availability
- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — using clocks to establish happens-before relations
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — capturing causal relationships
