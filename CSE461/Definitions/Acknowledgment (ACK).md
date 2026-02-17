## Acknowledgment (ACK)
A control message sent by a receiver to confirm that data was successfully received. Used in reliable protocols at multiple layers:
- **Link layer** — ACKs in [[Sliding Window Protocol]] and stop-and-wait protocols
- **Transport layer** — ACKs in [[Transmission Control Protocol (TCP)|TCP]] for reliable byte-stream delivery
- **Routing** — ACKs for reliable [[Link-State Packet (LSP)|LSP]] flooding

If an ACK is not received within a timeout, the sender retransmits.
