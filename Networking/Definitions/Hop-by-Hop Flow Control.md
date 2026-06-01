# CSE461: Hop-by-Hop Flow Control

**Hop-by-hop flow control** is a strategy where each pair of adjacent nodes along a path independently manages buffer usage. Each hop runs its own [[Sliding Window Protocol]] to prevent the upstream node from overrunning the downstream node's buffers.

Used in [[Virtual Circuit (VC)]] networks like X.25 to guarantee buffer availability at every switch.

## Related
- [[Sliding Window Protocol]] — the mechanism used at each hop
- [[Virtual Circuit (VC)]] — the network model where hop-by-hop flow control is common
- [[Advertised Window (rwnd)]] — end-to-end flow control in TCP (contrast)
