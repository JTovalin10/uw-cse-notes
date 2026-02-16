In order to support multicasting, we must extend it across multiple networks using broadcasting and multicasting.

**Broadcast:** Each switch forwards a frame with a destination broadcast address out on each active (selected) port other than the one on which the frame was received.

**Multicast:** Same as broadcast, but each host is allowed to decide whether or not to accept the message.

## Pruning with Spanning Tree
We can modify the [[Spanning Tree Algorithm]] to prune networks over which multicast frames need not be forwarded.

## How to Forward
How can a switch learn whether it should forward a multicast frame over a given port?
- It observes the source addresses that it receives over that port.
