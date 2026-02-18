## Overview
[[Virtual Circuit (VC)]] (VC) switching requires setting up a virtual connection from source to destination **before** any data is sent. This is a two-phase process: **connection setup** then **data transfer**.

![[Pasted image 20260214014920.png]]

## Connection State
Each switch along the path maintains an entry in a **VC table** containing:
- **[[Virtual Circuit Identifier (VCI)|VCI]]** — uniquely identifies the connection at this switch; carried in packet headers
- **Incoming interface** — port on which packets for this VC arrive
- **Outgoing interface** — port on which packets for this VC leave
- **Outgoing VCI** — a potentially different VCI placed in the header for the next hop

**Semantics**: If a packet arrives on the designated incoming interface with the designated VCI, forward it out the specified outgoing interface with the outgoing VCI in the header.

VCIs have **link-local scope** — they only need to be unique per port per switch, not globally.

## Connection Setup ([[Signalling]])
Two ways to establish connection state:
1. **[[Permanent Virtual Circuit|PVC]]**: Network admin manually configures the state; long-lived, manually deleted
2. **[[Switched Virtual Circuit|SVC]]**: A host sends a [[Signalling]] message to establish the circuit dynamically

### SVC Setup Process
1. Host A sends a **setup message** containing B's full destination address into the network
2. Each switch along the path creates a VC table entry and picks an unused VCI for its incoming port
3. The setup message propagates switch-by-switch until it reaches host B
4. Host B allocates its own incoming VCI and sends an **acknowledgment** back along the path
5. Each switch fills in the outgoing VCI from the ack, completing its table entry
6. Host A receives the ack with the VCI to use — the connection is ready

### Teardown
Host A sends a **teardown message** to switch 1, which removes its table entry and forwards the message along the path. All switches delete their entries; any subsequent packets using that VCI are dropped.

## Key Properties
- **Latency**: At least one RTT of delay before data can be sent (setup must complete first)
- **Small per-packet overhead**: Data packets carry only a small VCI (not a full address), and VCI lookup is fast (table index, not key search)
- **Fragile**: If a switch or link fails, the connection breaks — must tear down the old circuit and establish a new one
- **[[CSE461/Network/Routing]] still needed**: Switches must know where to forward setup requests, which is essentially the same routing problem as datagrams

## Resource Allocation
Because VCs have a setup phase, the network can reserve buffers and bandwidth per circuit at connection time — something datagrams can't easily do. This also enables per-circuit [[Quality of Service (QoS)|QoS]] guarantees. See [[VC Resource Allocation and QoS]] for the details and a comparison table against datagrams.
