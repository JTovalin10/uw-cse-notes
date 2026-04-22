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

An execution is **linearizable** if it is [[CSE452/Clocks/Sequential Consistency|sequentially consistent]] and additionally respects real-time ordering:

> If a request $r_2$ is submitted **after** the response to request $r_1$ is received, then $r_2$ must appear after $r_1$ in the apparent execution order.

**Linearizability** is **stricter** than sequential consistency — the ordering chosen must respect the wall-clock precedence of non-overlapping operations.

## Proving Linearizability

**To prove an execution is linearizable:**
- Show it is sequentially consistent and that the ordering chosen respects all real-time dependencies (i.e., for all non-overlapping request-response pairs, the ordering matches their real-time order).

**To prove an execution is NOT linearizable:**
- Show that there is no possible ordering of operations that is both consistent with the observed responses *and* respects all real-time ordering constraints.

## Related

- [[CSE452/Clocks/Sequential Consistency|Sequential Consistency]] — the weaker model that linearizability extends
- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — logical clocks for reasoning about event ordering
- [[CSE452/Primary-Backup/Primary Backup|Primary Backup]] — uses replication to provide consistency
- [[CSE451/Threads/concurrency.md]] — OS-level consistency and memory models
