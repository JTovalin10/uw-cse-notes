# Datacenter Systems: Datacenter Networking

How data moves between servers inside a warehouse-scale datacenter: the protocol layers and the physical path a packet takes, the APIs and hardware (NICs) that applications use, the switch topology that connects racks, and the congestion control needed to keep short messages fast when the network is shared.

---

## Topics

- [[Datacenter Systems/Datacenter Networking/Network Layers and Packet Path|Network Layers and Packet Path]] — Layers 1 to 7 in a datacenter, the packet header stack, and the hop-by-hop path from sender to receiver
- [[Datacenter Systems/Datacenter Networking/Network APIs|Network APIs]] — Stream sockets, datagram sockets, and RDMA
- [[Datacenter Systems/Datacenter Networking/Network Interface Cards|Network Interface Cards]] — NIC offloads, the RDMA NIC (RNIC), and the Smart NIC
- [[Datacenter Systems/Datacenter Networking/Network Topology|Network Topology]] — Why not one giant switch, Top of Rack switches, connected racks, Clos networks and fat trees, and oversubscription
  - [[Datacenter Systems/Datacenter Networking/Store-and-Forward Switch Internals|Store-and-Forward Switch Internals]] — Output queues, shared packet buffers, and the crossbar
  - [[Datacenter Systems/Datacenter Networking/ECMP Routing|ECMP Routing]] — Equal cost multipath routing, hashing, and failures
- [[Datacenter Systems/Datacenter Networking/Data Center Congestion Control|Data Center Congestion Control]] — Overload, goals, why congestion happens, incast/outcast, TCP congestion control, ECN, and DCTCP

---

## Related
- [[Datacenter Systems/Containers/Network Virtualization|Network Virtualization]] — Virtual vs physical addresses and packet encapsulation
- [[Datacenter Systems/Containers/Open vSwitch Network Virtualization|Open vSwitch Network Virtualization]] — Software switching and hardware-virtualized NICs
- [[Datacenter Systems/Warehouse-Scale Computer Architecture/Hardware Building Blocks|Hardware Building Blocks]] — Racks, servers, and the networking fabric
- [[CSE461 Index|CSE461 — Computer Networks]] — Layering, switching, and TCP in depth
