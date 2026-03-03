# TCP Segment Format

TCP is byte-oriented: sender writes bytes, receiver reads bytes. Data is buffered and sent in **segments** (packets). Each segment carries a segment of the byte stream.

## How TCP manages the byte stream

![How TCP manages a byte stream](https://book.systemsapproach.org/_images/f05-03-9780123850591.png)

- Source host buffers bytes from sending process → fills packet → sends to peer
- Destination host empties packet into receive buffer → receiving process reads at leisure

## Demux key

The 4-tuple uniquely identifies a TCP connection:
- **SrcPort, SrcIPAddr, DstPort, DstIPAddr**

Same port pair can be reused later (different *incarnation* of the connection).

## Header format

![TCP header format](https://book.systemsapproach.org/_images/f05-04-9780123850591.png)

![TCP data flow and ACKs (simplified, one direction)](https://book.systemsapproach.org/_images/f05-05-9780123850591.png)

## Header fields

| Field | Purpose |
|-------|---------|
| SrcPort, DstPort | [[Ports]] for demultiplexing |
| SequenceNum | First byte of data in this segment |
| Acknowledgement | Next sequence number expected (cumulative ACK) |
| AdvertisedWindow | Flow control; max unacknowledged bytes sender may have |
| Flags | SYN, FIN, RESET, PUSH, URG, ACK |
| HdrLen (Offset) | Header length in 32-bit words (variable due to options) |
| Checksum | Over header, data, pseudoheader |

## Flags

- **SYN** — connection establishment
- **FIN** — connection teardown
- **ACK** — Acknowledgement field is valid
- **URG** — urgent data; UrgPtr marks boundary
- **PUSH** — flush; notify receiver
- **RESET** — abort connection (receiver confused)

## Checksum

- Same as UDP: header + data + pseudoheader (src/dest IP, protocol, length)
- Required in both IPv4 and IPv6

## Related

- [[Transmission Control Protocol (TCP)]]
- [[Sliding Window]]
- [[Flow Control]]
- [[Ports]]
