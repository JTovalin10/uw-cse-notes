When a packet's destination [[IP Address]] matches multiple overlapping entries in a [[Forwarding Table]], the router forwards it using the **longest** (most specific) matching prefix.

A longer prefix covers fewer addresses and is therefore more specific — it is always preferred over a shorter, more general match.

## Example

| Prefix | Matches |
|---|---|
| `192.168.0.0/16` | All `192.168.x.x` addresses |
| `192.168.1.0/24` | Only `192.168.1.x` addresses |

A packet destined for `192.168.1.5` matches both, but the `/24` prefix is longer and wins.

## Implementation

A **Patricia tree** (also called a trie) is commonly used to implement longest prefix match efficiently — it allows the lookup to follow bits of the destination address one at a time, finding the longest match in O(address length) time.

See also: [[Classless Interdomain Routing (CIDR)]], [[IP Datagram Forwarding]], [[Forwarding Table]]
