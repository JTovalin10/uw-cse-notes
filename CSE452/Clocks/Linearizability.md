# CSE452: Linearizability

## Consistency Models

A **consistency model** answers the question: *what executions of a replicated state machine are correct?*

Formally, it is a predicate $f(\text{execution}) \rightarrow \text{boolean}$.

**Example scenarios:**
- **One client, one request at a time**: requests should execute in submission order — straightforward.
- **Two clients with concurrent requests**: both clients append to the same key; order is not determined by submission time alone.
  - $c_1$ sends `app(k, x)` and $c_2$ sends `app(k, y)` concurrently (assume the key starts empty).
  - If $c_1$ goes first: $c_1$ gets `AppRes(x)`, $c_2$ gets `AppRes(xy)`.
  - If $c_2$ goes first: $c_2$ gets `AppRes(y)`, $c_1$ gets `AppRes(yx)`.
  - Either result is valid under [[CSE452/Clocks/Sequential Consistency|sequential consistency]] — only *some* valid ordering needs to exist.

## Linearizability

An execution is **linearizable** if there exists a global order on client operations such that:
1. The responses sent to clients return the same answers as if the operations were executed in the global order.
2. The ordering agrees with the order each client sent their own requests in.
3. If a client receives a response and then later another client starts a new request, then the new request comes after the first request in the global order.

Linearizability is [[CSE452/Clocks/Sequential Consistency|sequentially consistent]] (points 1 and 2) and additionally respects real-time ordering (point 3):

> If a request $r_2$ is submitted **after** the response to request $r_1$ is received, then $r_2$ must appear after $r_1$ in the apparent execution order.

**Linearizability** is **stricter** than sequential consistency — the ordering chosen must respect the wall-clock precedence of non-overlapping operations.

## Proving Linearizability

**To prove an execution is linearizable:**
- **Linearization Points**: Identify a specific point in time (a "linearization point") for every operation between its invocation and its response. If all operations appear to occur atomically at their respective linearization points, and the results are consistent with a sequential execution in that order, the execution is linearizable.
- **Construct a Valid Order**: Find a total ordering of all operations that satisfies:
    1. It is consistent with the sequential specification of the object (e.g., a read returns the most recent write).
    2. It respects the real-time order (if $op_1$ finished before $op_2$ started, then $op_1 < op_2$).

**To prove an execution is NOT linearizable:**
- **Cycle in the Precedence Graph**: Construct a directed graph where nodes are operations and edges represent "must-precede" relationships. A cycle in this graph proves the execution is not linearizable.
  Edges exist if:
  - **Real-time constraint**: $op_1$ finished before $op_2$ started ($op_1 \rightarrow op_2$).
  - **Program order**: A single client submitted $op_1$ then $op_2$ ($op_1 \rightarrow op_2$).
  - **Data dependencies**: $op_2$ reads a value that could only have been produced by $op_1$ (or $op_2$ must see the state *after* $op_1$).
- **State Contradiction**: Show that any valid sequential ordering that respects real-time constraints would lead to a different result than what was observed (e.g., a "stale read" where a client reads an old value even though a newer write has already completed and been acknowledged).

## Related

- [[CSE452/Clocks/Sequential Consistency|Sequential Consistency]] — the weaker model that linearizability extends
- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — logical clocks for reasoning about event ordering
- [[CSE452/Primary-Backup/Primary Backup|Primary Backup]] — uses replication to provide consistency
- [[CSE451/Threads/concurrency.md]] — OS-level consistency and memory models
