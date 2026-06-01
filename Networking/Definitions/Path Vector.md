# Path Vector

A routing approach used by [[Border Gateway Protocol (BGP)]] where each route advertisement carries the **complete path** — an enumerated list of [[Autonomous System (AS)|AS]] numbers — to reach a destination prefix.

## Key points

- Unlike Distance-Vector Routing (cost only) or Link State Routing (full topology), path vector advertises the full AS path
- Used to **detect loops** — if a BGP speaker sees its own AS in the path, it rejects the route
- Enables **policy-based routing** — ASes can prefer or reject paths based on which ASes appear in the path

## See also

- [[Border Gateway Protocol (BGP)]] — uses path vector
- BGP Mechanics — how BGP advertises path vectors
- [[Autonomous System (AS)]]
