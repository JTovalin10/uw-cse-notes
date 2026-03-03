# User Datagram Protocol (UDP)

UDP is a minimal transport protocol — essentially a glorified packet. It doesn't guarantee reliability, ordering, or byte streams. Faster than [[Transmission Control Protocol (TCP)|TCP]] because it skips connection setup and reliability overhead.

## Characteristics

- **Datagram delivery** — each send delivers one discrete message (up to 64 KB minus headers)
- **No guarantees** — messages may be lost, reordered, or duplicated
- **Connectionless** — no handshake; can send regardless of receiver or network state
- **No flow/congestion control** — sender can blast packets at full rate
- **Limited message size** — max payload ~65,507 bytes (65,535 − 8-byte UDP header − 20-byte IP header)

If an application needs reliability, ordering, or byte streams, it must implement that itself (or use TCP).

## When to use UDP

- **Low latency** — no connection setup; first packet goes out immediately
- **Real-time** — voice, video; late data is often useless, retransmit hurts more than helps
- **Simple request–response** — one request, one reply; app can retry if needed
- **Multicast/broadcast** — TCP is point-to-point only; UDP supports one-to-many

## Applications

- **DNS** — simple queries; small messages; retries are cheap
- **DHCP** — bootstrap; client has no IP yet, uses broadcast
- **Voice/Video (VoIP, RTP)** — real-time; prefer loss over delay
- **RPC** — some RPC frameworks use UDP for fast, idempotent calls
- **Gaming** — low latency; game state often overwrites stale data
- **SNMP** — network management; periodic polls

## Header

8 bytes total:

| Field | Size | Purpose |
|-------|------|---------|
| Source port | 16 bits | Sender's port (optional; 0 if unused) |
| Dest port | 16 bits | Receiver's port — demultiplexing key |
| Length | 16 bits | UDP header + payload in bytes |
| Checksum | 16 bits | Optional; 0 means "no checksum" |

**Checksum** (when used) covers the UDP segment plus an IP **pseudoheader** (src/dest IP, protocol, UDP length). Catches some corruption and misdelivery. IPv6 requires checksum; IPv4 allows zero for "no checksum."

![[UDP header.png]]

## Ports and demultiplexing

UDP uses [[Ports|ports]] for process-to-process delivery. The tuple (IP address, protocol, port) identifies the endpoint. Servers bind to well-known ports (e.g., 53 for DNS, 67/68 for DHCP); clients use ephemeral ports.

## UDP vs TCP

| | UDP | TCP |
|---|-----|-----|
| Connection | None | 3-way handshake |
| Delivery | Best-effort | Reliable, ordered |
| Unit | Datagram | Byte stream |
| Flow control | No | Yes |
| Congestion control | No | Yes |
| Overhead | Minimal | Higher |

## Related

- [[Transmission Control Protocol (TCP)]] — reliable alternative
- [[Ports]] — demultiplexing
- [[Datagram]] — connectionless delivery model