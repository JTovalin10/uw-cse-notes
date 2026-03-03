# TCP Sliding Window and Flow Control

TCP's [[Sliding Window]] provides: (1) reliable delivery, (2) ordered delivery, (3) flow control. Unlike link-level, the receiver **advertises** window size via `AdvertisedWindow`.

![Relationship between TCP send buffer and receive buffer](https://book.systemsapproach.org/_images/f05-08-9780123850591.png)

## Buffers and pointers

**Sender:**
- `LastByteAcked` ≤ `LastByteSent` ≤ `LastByteWritten`
- Bytes left of LastByteAcked: already acknowledged, don't need to save
- Bytes right of LastByteWritten: not yet generated

**Receiver:**
- `LastByteRead` < `NextByteExpected` ≤ `LastByteRcvd + 1`
- NextByteExpected = byte after latest in-order byte (or start of first gap if out-of-order)
- Bytes left of LastByteRead: already read
- Bytes right of LastByteRcvd: not yet arrived

## Flow control

- Receiver advertises: `AdvertisedWindow = MaxRcvBuffer - ((NextByteExpected - 1) - LastByteRead)`
- Sender must obey: `LastByteSent - LastByteAcked ≤ AdvertisedWindow`
- **Effective window:** `EffectiveWindow = AdvertisedWindow - (LastByteSent - LastByteAcked)`
- When advertised window = 0 → sender sends **zero-window probes** (1-byte segments) every 5–60 s to discover when window reopens
- **Smart sender / dumb receiver** — receiver only responds, never initiates

## Wraparound

**Sequence numbers (32 bits):**
- Can wrap on high-speed links (OC-192: ~3 s)
- TCP extensions (timestamp, PAWS) address this

| Bandwidth | Time until wraparound |
|-----------|----------------------|
| T1 (1.5 Mbps) | 6.4 hours |
| OC-192 (10 Gbps) | 3 seconds |

**Advertised window (16 bits):**
- Max 64 KB — insufficient for delay × bandwidth on fast links
- Window scaling option extends this

| Bandwidth | Delay × bandwidth (100 ms RTT) |
|-----------|------------------------------|
| T3 (45 Mbps) | 549 KB |
| 10GigE (10 Gbps) | 118.4 MB |

## Silly window syndrome

- If sender sends small segments or receiver opens small windows → tiny "containers" circulate forever
- **Receiver fix:** After advertising zero window, wait for space ≥ MSS before reopening
- **Sender fix:** Nagle's algorithm

![Silly window syndrome](https://book.systemsapproach.org/_images/f05-09-9780123850591.png)

## Nagle's algorithm

**When to transmit:**
- If data ≥ MSS and window ≥ MSS → send full segment
- Else if unACKed data in flight → buffer until ACK
- Else → send now

- Interactive apps (e.g., Telnet) can disable via `TCP_NODELAY`

## Related

- [[Transmission Control Protocol (TCP)]]
- [[Sliding Window]]
- [[Flow Control]]
- [[Bandwidth-Delay Product]]
