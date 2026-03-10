# Network Layer: IPv4 Addressing and Subnetting

## Low-Level Primer: The IPv4 Address
An **[[IPv4]]** address is a 32-bit integer that uniquely identifies a network interface. To make them human-readable, they are typically expressed in **Dotted-Quad** notation (e.g., `128.96.33.81`), consisting of four 8-bit octets.

Historically, addresses were divided into rigid **Classes (A, B, C)** based on the leading bits. This was highly inefficient and was replaced by **CIDR** and **Subnetting**.

---

## 1. CIDR (Classless Inter-domain Routing)

CIDR allows for arbitrary-length network prefixes, specified using **Slash Notation** (e.g., `/24`).

*   **Subnet Mask**: A 32-bit value where the network bits are set to `1` and the host bits are set to `0`.
    *   Example: `/24` $\to$ `255.255.255.0`.
*   **The AND Operation**: To find the **Subnet Number**, a host performs a bitwise AND between the IP address and the Subnet Mask.
*   **Longest Prefix Match**: Routers may have overlapping entries in their forwarding tables (e.g., `128.96.0.0/16` and `128.96.33.0/24`). When a packet arrives, the router **must** use the most specific entry (the one with the longest mask).

---

## 2. Variable Length Subnet Masking (VLSM)

VLSM is the technique of recursively dividing a large network into smaller subnets of varying sizes to minimize address waste.

### The Subnetting Algorithm
1.  **Sort**: List all required subnets from largest to smallest (by host count).
2.  **Size**: For each subnet, find the smallest power of 2 ($2^n$) that can hold `Hosts + 2` (1 for Network ID, 1 for Broadcast).
3.  **Prefix**: The prefix length is $32 - n$.
4.  **Allocate**: Assign the addresses sequentially, starting from the base address.

### Common Prefix Sizes
| Prefix | Subnet Mask | Total IPs | Usable Hosts |
| :--- | :--- | :--- | :--- |
| **/30** | `255.255.255.252` | 4 | 2 (Point-to-point) |
| **/27** | `255.255.255.224` | 32 | 30 |
| **/24** | `255.255.255.0` | 256 | 254 |

---

## 3. Dynamic Host Configuration Protocol (DHCP)

DHCP automates the assignment of IP addresses, subnet masks, and default gateways.

### The 4-Step DORA Process
1.  **Discover**: Client broadcasts a message to find any available DHCP servers.
2.  **Offer**: Servers respond with a proposed IP address and lease duration.
3.  **Request**: Client selects one offer and broadcasts a request to use that IP.
4.  **Acknowledge (ACK)**: The server confirms the lease and provides configuration details.

---

## 4. Network Address Translation (NAT)

NAT is a mechanism used to map multiple **Private IPs** (from ranges like `192.168.x.x`) to a single **Public IP**.

*   **Motivation**: IPv4 address exhaustion.
*   **Mechanics**: The NAT router maintains a translation table. It replaces the internal (Source IP, Source Port) with the (Public IP, New Port) when packets leave the network, and does the reverse for incoming traffic.
*   **Controversy**: NAT violates the **End-to-End Principle**, as routers are now modifying application data and maintaining per-flow state.

---

## 5. IPv4 Header Format

A standard IPv4 header is **20 bytes** long.
*   **TTL (Time to Live)**: A hop-limit counter. If it reaches zero, the packet is discarded (prevents infinite loops).
*   **Protocol**: Identifies the next layer (e.g., 6 for TCP, 17 for UDP).
*   **Header Checksum**: Recalculated at every hop because the TTL changes.

[Image: Bit-level diagram of the IPv4 header fields]
