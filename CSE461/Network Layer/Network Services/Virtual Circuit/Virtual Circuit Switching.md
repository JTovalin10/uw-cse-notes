You can think of this as a telephone call.

[[Virtual Circuit (VC)]] switching requires setting up a virtual connection from source to destination **before** any data is sent. This is a two-phase process: **connection setup** then **data transfer**.

![[Pasted image 20260214014920.png]]

## Topics

- [[Virtual Circuit Connection Setup]] — signalling, PVC vs SVC, setup process, teardown
- [[Virtual Circuit Resource Allocation and QoS]] — resource reservation, QoS guarantees, comparison with datagrams

## Connection State

Each switch along the path maintains an entry in a **VC table** containing:
- **[[Virtual Circuit Identifier (VCI)|VCI]]** — uniquely identifies the connection at this switch; carried in packet headers
- **Incoming interface** — port on which packets for this VC arrive
- **Outgoing interface** — port on which packets for this VC leave
- **Outgoing VCI** — a potentially different VCI placed in the header for the next hop

**Semantics**: If a packet arrives on the designated incoming interface with the designated VCI, forward it out the specified outgoing interface with the outgoing VCI in the header.

VCIs have **link-local scope** — they only need to be unique per port per switch, not globally.

## Key Properties

- **Latency**: At least one RTT of delay before data can be sent (setup must complete first)
- **Small per-packet overhead**: Data packets carry only a small VCI (not a full address), and VCI lookup is fast (table index, not key search)
- **Fragile**: If a switch or link fails, the connection breaks — must tear down the old circuit and establish a new one
- **[[Routing]] still needed**: Switches must know where to forward setup requests, which is essentially the same routing problem as datagrams
