Once a node has a copy of the [[Link-State Packet (LSP)|LSP]] from every other node, it runs a shortest-path algorithm to build the forwarding table.

Uses a **forward search** algorithm — a modification of Dijkstra's — maintaining two lists:
- **Confirmed** — nodes whose shortest path is finalized
- **Tentative** — candidate nodes with a currently known (but not yet finalized) cost

Each entry in either list has the form `(Destination, Cost, NextHop)`.

See also: [[Link State Routing]], [[Routing]]

## Algorithm

1. Initialize `Confirmed` with an entry for myself with cost 0
2. For the node just added to `Confirmed` (call it `Next`), select its LSP
3. For each neighbor of `Next` (call it `Neighbor`), compute:
	- `Cost = cost(me → Next) + cost(Next → Neighbor)`
	1. If `Neighbor` is on **neither list** → add `(Neighbor, Cost, NextHop)` to `Tentative`, where `NextHop` is the first hop toward `Next`
	2. If `Neighbor` is on **`Tentative`** and the new `Cost` is lower → replace the existing entry
4. If `Tentative` is empty → stop
5. Otherwise, move the lowest-cost entry from `Tentative` to `Confirmed` and go to step 2

![[Pasted image 20260215203845.png]]
