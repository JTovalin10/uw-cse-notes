# CSE452: Linearizability and Sequential Consistency

A **consistency model** is a contract between a distributed system and the programmer. it answers the question: *what executions of a replicated state machine are correct?* Formally, it is a predicate $f(\text{execution}) \rightarrow \text{boolean}$ that determines if the observed results are legal under the promised semantics.

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

### Causal Consistency
Causal consistency relates operations that are causally linked (ordered by the **Happens-Before** relationship).
- If $W(x)1 \rightarrow W(x)2$, then all nodes must see the write of $1$ before the write of $2$.
- **Concurrent** writes (no causal link) can be seen in different orders by different nodes.
- **Cool Theorem**: Causal consistency is the strongest form of consistency that can be provided in an "always-available" convergent system (one that survives network partitions).

### Weak/Processor Consistency
- **Processor Consistency**: Writes by the same process are seen in order, but writes by different processes can be seen in different orders by different readers.
- **Memory Barrier / Fence**: Primitives used in lower-level programming (see: [[CSE351/Memory and Data/x86-64 Programming|x86-64 Assembly]]) to enforce ordering. Read/writes can be reordered by the hardware/compiler but cannot cross a fence.

### Eventual Consistency
If all writes to the system stop, eventually all processes will read the same value. This is the weakest common model and is used by systems like DNS or Amazon's Dynamo (AP systems).

---

## Example Scenario: The Stale Read
Suppose a key `x` starts at `0`.
1. **Client A** writes `x = 1` and receives an ACK.
2. **Client B** starts a read later and gets `x = 0`.

- **Is this Linearizable?** No. Operation A finished before B started, so A must be before B. B must see `1`.
- **Is this Sequentially Consistent?** Yes, as long as there's no other operation from B that forces A to be earlier. We can say the total order was `Read_B(x)0 -> Write_A(x)1`. This respects program order for both.

---

## Related
- [[CSE452/Consistency/Memory Consistency Model|Memory Consistency Model]] — how these concepts apply to hardware memory
- [[CSE452/Consistency/CAP Theorem and Partitions|CAP Theorem and Partitions]] — the trade-off between consistency and availability
- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — using clocks to establish happens-before relations
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — capturing causal relationships
- [[CSE451/Concurrency/Threads/concurrency|OS Concurrency]] — threading and synchronization primitives
