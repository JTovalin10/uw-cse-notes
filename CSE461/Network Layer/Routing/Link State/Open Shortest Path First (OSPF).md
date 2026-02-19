One of the most widely used [[Link State Routing|link-state]] routing protocols. OSPF builds on the basic link-state algorithm and adds:

1. **Authentication of routing messages** — bad info from a single node can affect the whole network; authenticating messages ensures all participants can be trusted. Early versions used an 8-byte password; later versions added strong cryptographic authentication.
2. **Additional hierarchy** — a domain can be partitioned into *areas*. Routers only need to know how to reach the right area, not every network within the domain. Reduces info stored and transmitted per node.
3. **Load balancing** — multiple equal-cost routes to the same destination share traffic evenly, making better use of available capacity.

![[Pasted image 20260215204052.png]]

See also: [[Link State Routing]], [[Route Calculation]], [[Routing]]

## Advertisements

A router generates two types of advertisements:
1. **Network advertisements** — the networks directly connected to the router
2. **Link cost advertisements** — the cost of reaching a neighboring router over a link

Together these allow all routers in a domain to determine the cost to reach all networks and the correct next hop.

![[Pasted image 20260215204155.png]]

## Type 1 [[Link-State Advertisement (LSA)]] Fields

| Field | Description |
|---|---|
| `Link state ID` / `Advertising router` | Identical; both carry a 32-bit router identifier — must be unique in the domain. Common strategy: use the lowest IP address among the router's interfaces. |
| `LS sequence number` | Detects old or duplicate LSAs |
| `LS checksum` | Verifies data integrity ([[Checksum]]); covers all fields except `LS Age` so no recomputation is needed when the age increments |
| `Length` | Length in bytes |
