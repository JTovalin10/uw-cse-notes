## Resource Allocation in Virtual Circuits
Because VCs have an establishment phase, resources can be reserved at setup time. The classic example is **X.25** (now largely obsolete), which used **[[Hop-by-Hop Flow Control]]**:
1. Buffers allocated to each VC at initialization
2. [[Sliding Window Protocol]] with flow control between each pair of nodes prevents buffer overrun
3. Connection rejected if a node lacks sufficient buffers

This guarantees each node has the buffers it needs to queue packets for that circuit.

## [[Quality of Service|QoS]]
VCs can provide per-circuit **QoS guarantees**, such as:
- Allocating a percentage of a link's bandwidth to a circuit
- Bounding the maximum queuing delay for packets on a circuit

## Datagrams vs Virtual Circuits
| | Datagrams | Virtual Circuits |
|---|---|---|
| Setup delay | None | At least 1 RTT |
| Per-packet header | Full destination address | Small VCI |
| Resource allocation | Packets compete for buffers | Can reserve resources at setup |
| Failure handling | Reroute if alt path exists | Connection breaks, must re-establish |
| QoS | Difficult to guarantee | Can provide per-circuit guarantees |

## Historical Context
Notable VC technologies: X.25, Frame Relay, ATM. With the success of the Internet's connectionless model, none are widely used today. VPNs were a common VC application but are now mostly built on Internet-based technologies.
