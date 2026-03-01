Each layer has its own address type. When you see **L2 address** or **L3 address**, it refers to the address used at that layer:

| Notation | Layer | Address Type | Example | Scope |
|---|---|---|---|---|
| **L2 address** | Link (Layer 2) | MAC address | `00:1A:2B:3C:4D:5E` | Local network only — used to deliver a frame between two directly connected nodes |
| **L3 address** | Network (Layer 3) | IP address | `192.168.1.1` (IPv4), `2001:db8::1` (IPv6) | Global — used to route a packet across networks |
| **L4 address** | Transport (Layer 4) | Port number | `:443`, `:80` | Identifies a specific process/service on a host |

> When a packet travels across networks, the **L3 address (IP) stays the same** end-to-end, but the **L2 address (MAC) changes at every hop** as the frame is handed off between links.

## Address Resolution

Protocols that bridge the gap between layers:

| Protocol | Resolves |
|---|---|
| **ARP** | L3 (IPv4) → L2 (MAC) |
| **NDP** | L3 (IPv6) → L2 (MAC) |
| **DNS** | Hostname → L3 (IP) |

See also: [[Layering]], [[IP Address Resolution Protocol (ARP)]], [[Neighbor Discovery Protocol (NDP)]]
