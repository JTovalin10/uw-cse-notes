# Transmission Control Protocol (TCP)

TCP provides a **reliable, ordered byte stream** over a connection. Full-duplex: pair of byte streams, one in each direction.

## Key features

- Byte stream delivery — sender writes bytes, receiver reads bytes
- Connection via 3-way handshake
- Bytes delivered once, reliably, in order
- **Flow control** — matches sender rate to receiver capacity
- **Congestion control** — matches sender rate to network capacity
- Demultiplexing — multiple apps per host can have concurrent connections

**Flow vs congestion control:**
- Flow control = end-to-end; prevents sender from over-running receiver
- Congestion control = host–network; prevents overloading the network

## Connection establishment

Both sides must be ready before data transfer. Must agree on parameters (e.g., [[Maximum Transmission Unit (MTU)|MSS]]).

### Three-way handshake

- Opens connections for data in both directions
- Each side probes with a fresh Initial Sequence Number (ISN)
	- Client sends SYN(x)
	- Server replies SYN+ACK(y), ACK(x+1)
	- Client sends ACK(y+1)
- Robust against delayed duplicates — even worst-case delayed/duplicated segments are cleanly rejected
- ISNs chosen at random to protect against old segments from prior connection incarnations

![[Three-Way Handshake.png]]

![Three-way handshake timeline](https://book.systemsapproach.org/_images/f05-06-9780123850591.png)

### Connection release

- Orderly release; both sides shut down independently
- Deliver all pending data, then hang up
- Key problem: reliability while releasing
- Symmetric close — each side closes its half

**Sequence:**
1. Active side sends FIN(x), passive ACKs
2. Passive side sends FIN(y), active ACKs
3. FINs retransmitted if lost

Each FIN/ACK closes one direction of data transfer.

![TCP connection release / state-transition diagram](https://book.systemsapproach.org/_images/f05-07-9780123850591.png)

![[TCP Connection Release.png]]

**State transitions (teardown):**
- This side closes first: ESTABLISHED → FIN_WAIT_1 → FIN_WAIT_2 → TIME_WAIT → CLOSED
- Other side closes first: ESTABLISHED → CLOSE_WAIT → LAST_ACK → CLOSED
- Both close at once: ESTABLISHED → FIN_WAIT_1 → CLOSING → TIME_WAIT → CLOSED

## TIME_WAIT state

- Wait 2× MSL (typically 60 s) after sending final ACK before completing close
- **Why:** ACK might be lost → FIN will be resent for orderly close; delayed FIN could otherwise interfere with a new connection reusing same ports

## Detailed topics

- [[TCP End-to-End Issues]] — differences from link-level sliding window
- [[TCP Segment Format]] — header fields, demux key
- [[TCP Sliding Window and Flow Control]] — buffers, advertised window, Nagle, silly window
- [[TCP Adaptive Retransmission]] — RTT estimation, Karn/Partridge, Jacobson/Karels
- [[TCP Extensions and Alternatives]] — SACK, window scaling, QUIC, SCTP

## Related

- [[User Datagram Protocol (UDP)]] — unreliable alternative
- [[Sliding Window]] — TCP uses selective repeat
- [[Flow Control]] — advertised window
