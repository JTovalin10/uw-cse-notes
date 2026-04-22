# CSE452: Sequential Consistency

**Sequential consistency** is a consistency model that answers the question: *which executions are allowed?*

An execution is **sequentially consistent** if there exists some total ordering of all client operations such that:
1. The responses returned by the replicated state machine agree with executing the requests in that order.
2. The total order is consistent with each individual client's local order of operations.

## Key Point

Sequential consistency does **not** say anything about which ordering is chosen — only that *some* valid ordering must exist. It does not consider whether one request was submitted before another in real time; any ordering that produces consistent responses is acceptable.

## How to Verify

1. Enumerate possible orderings of the concurrent client operations.
2. For each ordering, simulate the state machine and compare the produced responses to what was actually returned.
3. If any ordering produces matching responses for all clients, the execution is sequentially consistent.

## Related

- [[CSE452/Clocks/Linearizability|Linearizability]] — a stricter model: sequentially consistent *and* real-time ordering must be respected
- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — logical time used to reason about ordering in distributed systems
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — state machine replication assumes operations execute in a total order
- [[CSE451/Threads/concurrency.md]] — OS-level concurrency and memory models
