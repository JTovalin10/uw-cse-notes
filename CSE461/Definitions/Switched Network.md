# Switched Network

Traffic forwarded through **switches** that learn where to send [[Frame|frames]] by destination address. Sends only to the port toward the destination — not broadcast.

**Contrast:** broadcast networks (e.g., hub Ethernet) — every transmission heard by all nodes.

## Properties

- Switches use [[Backwards Learning]] to build port/address tables
- Can create forwarding loops if switches in a cycle → [[Spanning Tree Algorithm]]
- [[Virtual Local Area Network (VLAN)]] — partitions one physical switched network into multiple logical LANs

## See also

- [[Network Switch (Switching)]] — how switching works
- [[Virtual Local Area Network (VLAN)]] — logical segmentation
