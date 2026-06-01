# Next Hop Router

The adjacent [[Router]] to which a packet should be [[Forwarding|forwarded]] for a given destination. The [[Forwarding Table]] maps destination prefixes to next-hop routers (or output ports).

## Key points

- Each forwarding table entry specifies: prefix → next hop
- The router forwards the packet to the next hop; that router repeats the process
- [[Longest matching prefix]] selects which entry (and thus which next hop) to use when prefixes overlap

## See also

- [[Forwarding Table]] — stores prefix → next hop mappings
- IP Datagram Forwarding — the forwarding algorithm
- [[Routing]] — how next hops are computed
