# Datacenter Networking: Network Interface Cards

This note follows the progression of how much network work is moved off the CPU and onto the NIC: a regular NIC that only moves packets (and a few checks), the RDMA NIC that lets applications touch remote memory directly, and the Smart NIC that runs full programs.

---

## Network Interface Card (NIC)

- The **NIC** pulls packets off a ring buffer and transmits them on the wire/cable.
- Base case: retransmission, access control, and flow control all happen in the guest OS.
- To support higher-speed network links, we move work from the guest OS to the NIC:
  - Ethernet CRC and TCP/IP checksum.
  - **Segment offload**: the host provides a large chunk, and the NIC cuts it into packets.
  - Routing of incoming packets to waiting cores.
  - Encryption and decryption for SSL.
  - Azure/Amazon: the host OS layer's virtual network translation, which allows direct guest OS access (or direct application access).

### Regular NIC Mechanics

- Ring buffers are used to communicate with the DMA engine that sits on the NIC.
  - Software tells the NIC which buffers to preallocate, including the header and everything else required.
  - Once this is set up, everything else is handled by the NIC without per-packet software work.
- Checksum calculation was originally done in software but is now done in the NIC. To do this, the NIC needs some understanding of the protocols, so that knowledge is encoded into the NIC.
- It is computationally cheaper to process fewer packets that carry more information than many small packets. This is **segmentation offload**:
  - Packetizing data is now the NIC's role.
  - This reduces CPU overhead.
- The receive queue should also expect a response to anything we send, since most likely we are getting something back.

```mermaid
flowchart LR
    APP[Guest OS / application] -->|large chunk + buffer descriptors| RB[Ring buffer]
    RB --> DMA[DMA engine on NIC]
    DMA --> SEG[Segment offload: cut into packets]
    SEG --> CK[Compute CRC and checksum]
    CK --> WIRE[Wire / cable]
```

---

## RDMA Network Interface Card (RNIC)

- Gives **direct application access to the network**: read/write a remote memory region.
- The RNIC enforces memory limits for security and isolation:
  - An application can only read/write its own region.
  - The region must be **pinned** in memory, that is, not paged out. The OS must keep it in the physical location it had when it was registered and cannot swap it out. The OS must inform the NIC before swapping it out so the NIC does not overwrite memory that does not belong to what we intended.
  - The RNIC can access or reject memory regions.
  - Memory regions we want other hosts to communicate with must be pinned.
- Division of work:
  - The receiver NIC interprets incoming packets, performs the DMA, and formats the reply.
  - The sender NIC handles retransmission and congestion control, with limited functionality compared to the guest OS network stack.
- Trade-off: we do not want to bake too much into hardware, because we would have to wait 3-5 years for the next change.

---

## Smart NIC

- The idea: put processing on the NIC.
  - It could handle some RPCs on the NIC without involving the host CPU. This is common in high-speed trading systems.
  - Examples: RDMA, Paxos, two-phase commit, etc.
- If we move TCP handling onto the NIC:
  - The interface to the application can be a ring buffer with reliable transport.
  - Routing of incoming data to specific ring buffers/cores becomes programmable.
- A Smart NIC is fully programmable. It usually has its own OS and CPU, which offloads the host OS CPU: basically, the OS network stack is offloaded onto it.

| NIC type | Where protocol work happens | Programmability |
|---|---|---|
| Regular NIC | CRC, checksum, segmentation on NIC; retransmission and flow control in guest OS | Fixed function |
| RNIC | Remote memory access, retransmission, and congestion control on NIC | Limited |
| Smart NIC | Potentially the entire network stack and some RPC handling | Fully programmable, with its own OS and CPU |

---

## Industry Standard Terms

| Course term | Industry equivalent |
|---|---|
| Segment offload | TCP Segmentation Offload (TSO) / Large Send Offload |
| Pinned memory region | Registered / pinned memory region (memory registration) |
| Smart NIC | DPU / IPU (data processing unit) |
| Ring buffer + DMA engine | Descriptor ring / DMA queue |

---

## Related
- [[Datacenter Systems/Datacenter Networking/Datacenter Networking|Datacenter Networking]]
- [[Datacenter Systems/Datacenter Networking/Network APIs|Network APIs]]
- [[Datacenter Systems/Datacenter Networking/Network Layers and Packet Path|Network Layers and Packet Path]]
- [[Datacenter Systems/IO Virtualization/DMA Ring Buffers|DMA Ring Buffers]]
- [[Datacenter Systems/IO Virtualization/SR-IOV and IOMMU|SR-IOV and IOMMU]]
- [[Datacenter Systems/Containers/Open vSwitch Network Virtualization|Open vSwitch Network Virtualization]] — hardware-virtualized NICs
- [[Networking/Definitions/Cyclic Redundancy Check (CRC)|Cyclic Redundancy Check (CRC)]]
