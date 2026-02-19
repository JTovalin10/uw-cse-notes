When a node cannot deliver a packet directly (the destination is on a different network), it forwards the packet to the **next hop router** — the neighboring router most likely to get the packet closer to its destination.

The next hop is determined by looking up the destination [[IP Address]] in the node's [[Forwarding Table]], applying [[Longest Prefix Match]] to find the best entry.

See also: [[IP Datagram Forwarding]], [[Router]], [[Forwarding Table]]
