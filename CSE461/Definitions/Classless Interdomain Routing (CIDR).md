## Classless Interdomain Routing (CIDR)
An addressing scheme that removes the old Class A/B/C system and uses variable-length prefixes (e.g., `/24`) to allocate address space more efficiently. Creates **aggregate routes** so a single [[Forwarding Table]] entry can cover many networks.

When prefixes overlap, the **longest prefix match** rule is used. Efficient lookup is done with a **Patricia tree**.

See also: [[Classless Interdomain Routing  (CIDR)]], [[Subnet]]
