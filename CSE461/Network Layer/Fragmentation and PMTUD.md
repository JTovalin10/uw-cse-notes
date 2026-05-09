# Network Layer: Fragmentation and PMTUD

### Formal Definition
**IP Fragmentation** is the process of breaking an IP datagram into smaller pieces (fragments) so they can pass through a link with a smaller **Maximum Transmission Unit (MTU)**. **Path MTU Discovery (PMTUD)** is the modern technique to avoid fragmentation entirely.

### Simplified Explanation
If you have a large box that won't fit through a door, you can either take it apart (Fragmentation) or measure the door first and use a smaller box (PMTUD).

---

## 1. IP Fragmentation
Fragmentation occurs when a router receives a packet larger than the MTU of the next hop.
- **Header Fields**:
  - **Identification**: 16-bit ID shared by all fragments of the same datagram.
  - **Flags**: 
    - `DF` (Don't Fragment): If set, the router drops the packet and sends ICMP Type 3, Code 4.
    - `MF` (More Fragments): Set to 1 for all fragments except the last one.
  - **Fragment Offset**: Indicates the position of the fragment in the original datagram (in units of 8 bytes).
- **The Cost**:
  - **CPU/Memory**: Reassembly at the destination is expensive and consumes buffer space.
  - **Reliability**: If any single fragment is lost, the *entire* datagram must be retransmitted.

## 2. Path MTU Discovery (PMTUD)
Modern protocols (TCP) and IPv6 prefer PMTUD to avoid fragmentation.
- **Mechanism**:
  1. The source sends packets with the `DF` (Don't Fragment) bit set.
  2. If a router encounters a link with a smaller MTU, it drops the packet.
  3. The router sends back an **ICMP "Fragmentation Needed"** message containing the MTU of the bottleneck link.
  4. The source reduces its **MSS (Maximum Segment Size)** and retries.
- **ICMP Black Holes**: Firewalls that block all ICMP messages prevent PMTUD from working, causing connections to "hang" when large packets are sent.

## 3. IPv6 Improvements
- IPv6 **forbids** fragmentation by intermediate routers. 
- Only the source host can fragment (using a specialized Fragment Extension Header).
- Routers MUST send ICMPv6 Packet Too Big messages, mandating PMTUD.

### Related
- [[CSE461/Definitions/Maximum Transmission Unit (MTU)]]
- [[CSE461/Network Layer/Internet Protocol (IP)]]
- [[CSE461/Definitions/Internet Control Message Protocol (ICMP)]]
