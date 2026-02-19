How a [[Virtual Circuit Switching|virtual circuit]] is established and torn down using [[Signalling]].

Two ways to establish connection state:
1. **[[Permanent Virtual Circuit|PVC]]** — network admin manually configures the state; long-lived, manually deleted
2. **[[Switched Virtual Circuit|SVC]]** — a host sends a signalling message to establish the circuit dynamically

See also: [[Virtual Circuit Switching]], [[Virtual Circuit Resource Allocation and QoS]]

## SVC Setup Process

1. Host A sends a **setup message** containing B's full destination address into the network
2. Each switch along the path creates a VC table entry and picks an unused VCI for its incoming port
3. The setup message propagates switch-by-switch until it reaches host B
4. Host B allocates its own incoming VCI and sends an **acknowledgment** back along the path
5. Each switch fills in the outgoing VCI from the ack, completing its table entry
6. Host A receives the ack with the VCI to use — the connection is ready

## Teardown

Host A sends a **teardown message** to switch 1, which removes its table entry and forwards the message along the path. All switches delete their entries; any subsequent packets using that VCI are dropped.
