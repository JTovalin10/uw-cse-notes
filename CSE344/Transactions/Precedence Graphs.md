# Transactions: Precedence Graphs

A **precedence graph** (also called a **serialization graph**) is used to verify whether a schedule is [[Isolation Transactions in SQL#Conflict-Serializability and Serializability|conflict-serializable]].

## Structure

- One node per transaction $T_i$
- A directed edge from $T_i$ to $T_j$ whenever any action in $T_i$ conflicts with any action in $T_j$
	- The edge points at the transaction that needs to proceed first

## How It Verifies Conflict-Serializability

Modeling conflicts as precedence constraints turns conflict-serializability into a **cycle detection** problem:

> A schedule is conflict-serializable **if and only if** its precedence graph is **acyclic**.

![[Precedence Graphs Verify Conflict serializability.png]]

## Other Uses

- Aborting and retrying transactions on cycle detection
- Lock management for data elements
- Smart commit ordering before execution

## Building a Precedence Graph

1. Iterate through all pairs of transaction operations to determine the hypothesized serial schedule's transaction precedence
2. Can generate all pairs in two ways:
	1. Iterate over the schedule by time
	2. Iterate over the schedule by transaction

## Related
- [[Isolation Transactions in SQL]] — conflict-serializability definition
- [[Atomic and isolated Transactions in SQL]] — 2PL as a mechanism that generates acyclic precedence graphs
