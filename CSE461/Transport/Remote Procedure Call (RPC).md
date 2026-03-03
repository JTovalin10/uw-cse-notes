# Remote Procedure Call (RPC)

A transport paradigm for **request/reply** message transactions: client sends a request, blocks until the server replies. Fits client/server applications better than raw [[User Datagram Protocol (UDP)|UDP]] (which lacks correlation) or [[Transmission Control Protocol (TCP)|TCP]] (which is byte-stream, not message-oriented).

![Timeline for RPC](https://book.systemsapproach.org/_images/f05-13-9780123850591.png)

## RPC fundamentals

RPC is a mechanism, not a single protocol. Application calls a procedure without caring if it's local or remote; blocks until the call returns.

**Two main challenges:**
1. **Network** — limits message size, loses/reorders messages
2. **Heterogeneity** — different machines have different data representations

**Two components:**
1. **Protocol** — manages messages, deals with network limitations
2. **Stub compiler** — packages arguments into request messages, unpacks return values

**Flow:** Client → local stub → RPC protocol → server stub → server procedure → reply back

![Complete RPC mechanism](https://book.systemsapproach.org/_images/f05-14-9780123850591.png)

## Identifiers in RPC

### Procedure naming

- **Flat** — unique integer (requires central coordination)
- **Hierarchical** — program + procedure number (like file pathnames)

### Request/reply matching

- **Message ID** — reply carries same ID as request
- **Boot ID** — avoids duplicate-ID confusion after client crash/reboot; combined with message ID for unique transaction ID

## Overcoming network limitations

### Reliability

- Run over [[Transmission Control Protocol (TCP)|TCP]] (outsource reliability) or implement own ACKs/timeouts over [[User Datagram Protocol (UDP)|UDP]]
- **Implicit ACK** — reply message acknowledges request; next request acknowledges prior reply (if transactions are sequential)
- **Channels** — multiplex multiple request/reply transactions; each channel is sequential
- **At-most-once semantics** — server recognizes duplicates, ignores them; requires state (e.g., sequence number per channel)
- **Zero-or-more semantics** — simpler; OK if procedure is idempotent

![Simple timeline for reliable RPC](https://book.systemsapproach.org/_images/f05-15-9780123850591.png)

![Timeline with implicit acknowledgment](https://book.systemsapproach.org/_images/f05-16-9780123850591.png)

- Client can send "Are you alive?" or server sends "I am still alive" to distinguish slow vs dead server

### Fragmentation

- RPC may implement its own fragmentation/reassembly (e.g., per-fragment ACK/NACK) for faster recovery than IP fragmentation

## Synchronous vs asynchronous

- **Synchronous** — `send` returns when reply received; RPC is usually synchronous
- **Asynchronous** — `send` returns immediately; sender knows nothing about delivery

## RPC implementations

### SunRPC (ONC RPC)

![Protocol graph for SunRPC on UDP](https://book.systemsapproach.org/_images/f05-17-9780123850591.png)

![SunRPC header formats](https://book.systemsapproach.org/_images/f05-18-9780123850591.png)

- Two-tier IDs: 32-bit program number + 32-bit procedure number
- **Port Mapper / RPCBIND** — well-known port 111; clients look up program → transport selector
- **XID** (transaction ID) in request/reply; server doesn't remember XID after reply → no at-most-once guarantee
- Relies on underlying transport for reliability and message size

### DCE-RPC

![Typical DCE-RPC message exchange](https://book.systemsapproach.org/_images/f05-19-9780123850591.png)

![Fragmentation with selective acknowledgments](https://book.systemsapproach.org/_images/f05-20-9780123850591.png)

- **At-most-once** semantics (default)
- **Activity** — logical channel; one transaction per activity at a time
- **ActivityId** + **SequenceNum** — server tracks to detect duplicates
- **Fragmentation** — selective ACK (Fack) for fragments; flow control via WindowSize
- Client sends Request; server replies Response; client Acks; client may Ping, server replies Working

### gRPC

![Using RPC to invoke a scalable cloud service](https://book.systemsapproach.org/_images/Slide13.png)

![gRPC stack](https://book.systemsapproach.org/_images/Slide21.png)

- Designed for **cloud services** (scalable, load-balanced)
- Runs on **HTTP/2** over **TLS** over [[Transmission Control Protocol (TCP)|TCP]]
- Outsources: reliability, security, encoding, multiplexing
- **Streaming** — simple RPC, server streaming, client streaming, bidirectional streaming
- Uses **Protocol Buffers** for encoding

## Related

- [[User Datagram Protocol (UDP)]] — often used as substrate
- [[Transmission Control Protocol (TCP)]] — alternative substrate
- [[Ports]] — demultiplexing
- [[Sliding Window]] — reliability mechanism
