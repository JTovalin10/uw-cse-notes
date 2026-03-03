# Transmission Control Protocol (TCP)

TCP is a full-featured transport protocol that provides a reliable, ordered byte stream. Key features:
- Byte streams to deliver data
- Creates a connection with a 3-way handshake
- Bytes are delivered once, reliably, and in order
- Arbitrary length content
- **Flow control** — matches sender rate to receiver
- **Congestion control** — matches sender rate to network capacity

## Phases
###  Connection Establishment (setup)
Both senders and receivers must be ready before we start the transfer of data
- need to agree on a set of parameters
- Maximum segment size (MSS)
#### Three-way Handshake
- opens connections for data in both directions
- each side probes the other with a fresh Initial Sequence Number (ISN)
	- sends on a SYNchronize segment
	- echo on an ACKnowledge segment
- This is robust even against delayed duplicates
	- even in a worst case scenario where it's delayed and duplicated the connection will be cleanly rejected on both sides
![[Three-Way Handshake.png]]
#### Connection Release
- orderly release by both parties when done
	- deliver all pending data and hangs up
	- cleans up state in sender and receiver
- key problem is to provide reliability while releasing
	- TCP uses a symmetric close in which both sides shutdown independently
**Steps:**
1. Active side sends FIN(x), passive ACKs
2. Passive side sends FIN(y), active ACKs
3. FINs are retransmitted if lost

Each FIN/ACK closes one direction of data transfer.
![[TCP Connection Release.png]]
## TIME_WAIT state

- Wait a long time after sending all segments and before completing the close
	- Two times the maximum segment lifetime (typically 60 seconds)
- **Why:**
	- ACK might have been lost, in which case FIN will be resent for an orderly close
	- could otherwise interfere with a subsequent connection

## Related

- [[User Datagram Protocol (UDP)]] — unreliable alternative
- [[Sliding Window]] — TCP uses selective repeat
- [[Flow Control]] — advertised window