# Classless Interdomain Routing (CIDR)

Replaces [[IP Address Classes (Classful Addressing)|Class A/B/C]] with variable-length prefixes. One [[Forwarding Table]] entry can cover many networks.

## Key points

- Variable-length prefixes (e.g., `/24`) — allocate address space efficiently
- Overlapping prefixes → **longest prefix match** rule
- Lookup: **Patricia tree** — a compact trie (radix tree) used for fast prefix lookup; supports longest-prefix match by searching from root to leaf

See also: [[Subnet]], [[Forwarding Table]], [[Longest matching prefix]]


![[Screenshots/Route Aggregation with CIDR.png]]
