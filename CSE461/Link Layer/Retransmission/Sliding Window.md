# Sliding Window

Generalization of [[Stop-and-Wait]] that allows multiple frames in flight. Keeps the pipe full for higher throughput.

## Flow control problem

Sliding window uses pipelining to keep the network busy. But what if the receiver is overloaded?

- Consider a receiver with W buffers:
	- **LAS** = last ACK sent; the app pulls in-order data from the buffer via `recv()` calls
- If segments arrive faster than the app calls `recv()`:
	- LAS rises, but we can't slide the window
- Further in-order segments arrive and fill the buffer:
	- Must drop segments until the app calls `recv()`
- When the app's `recv()` consumes segments:
	- The window slides

**Flow control** avoids loss at the receiver by telling the sender the available buffer space:
- **WIN** = number of acceptable bytes (not W)
- Sender uses the **minimum** of the sliding window and the flow control window (WIN) as the effective window size
- [[Transmission Control Protocol (TCP)|TCP]] implements this via the advertised window in each ACK
## Key idea

- Allows **W frames** to be outstanding (window size)
- Can send W frames per [[Round-Trip Time (RTT)|RTT]]
- Various options for numbering frames/ACKs and handling loss

![[Pasted image 20260207013628.png]]

---

## State variables and invariants

### Sender

- **SWS** (Send Window Size) — max outstanding frames
- **LAR** (Last ACK Received) — sequence number of last acknowledged frame
- **LFS** (Last Frame Sent) — sequence number of last frame sent

**Invariant:** `LFS - LAR <= SWS`

When an ACK arrives, LAR advances, allowing the sender to transmit another frame. Each frame has a timer — if it expires before an ACK arrives, the frame is retransmitted. The sender must buffer up to SWS frames for potential retransmission.

![[Pasted image 20260207013610.png]]

### Receiver

- **RWS** (Receive Window Size) — max out-of-order frames it will accept
- **LAF** (Largest Acceptable Frame) — sequence number of the largest acceptable frame
- **LFR** (Last Frame Received) — sequence number of the last frame received

**Invariant:** `LAF - LFR <= RWS`

When a frame with sequence number `SeqNum` arrives:
1. `SeqNum <= LFR` or `SeqNum > LAF` → **discard**
2. `LFR < SeqNum <= LAF` → **accept** (within window)
3. Find the largest `SeqNumToAck` such that all frames up to it have been received → send **cumulative ACK** for `SeqNumToAck`
4. Set `LFR = SeqNumToAck`, `LAF = LFR + RWS`

---

## Retransmission strategies

### Go-Back-N

Simplest version but can be inefficient.

- Uses a **single timer** to detect losses; on timeout, resends all buffered packets starting at LAR + 1
- Receiver keeps only a **single packet buffer** for the next expected segment
- **State:** LAS = last ACK sent
- **On receive:**
  - If seq num is LAS + 1 → accept, pass to app, update LAS, send ACK
  - If out of order → discard

### Selective Repeat

Better performance; resends only lost segments.

- Uses a **timer per unacked segment** to detect losses; on timeout, resend only that segment
- Receiver **buffers out-of-order segments** to reduce retransmissions
- ACK conveys highest in-order segment, plus hints about out-of-order segments
- **State:** LAS = last ACK sent; buffer W segments
- **On receive:**
  - Buffer segments [LAS + 1, LAS + W]
  - Pass in-order segments from LAS + 1 to app, update LAS
  - Send ACK for LAS regardless
  - If out of order → send last unacked packet again (duplicate ACK)
  - If correct packet arrives → move window and LAR, send more messages

[[Transmission Control Protocol (TCP)]] uses a selective repeat design.

---

## Important considerations

### Pipe drain on loss

When a timeout occurs, the sender can't advance its window until the lost frame is acknowledged. Data in transit decreases and the pipe is no longer full. The longer it takes to notice a loss, the worse this gets.

### Finite sequence numbers

Sequence numbers can't grow forever. The number of possible sequence numbers must be larger than the number of outstanding frames. When `RWS = SWS`:
```
SWS < (MaxSeqNum + 1) / 2
```

---

## Related

- [[Stop-and-Wait]] — single-frame version
- [[Transmission Control Protocol (TCP)]] — uses selective repeat
- [[Automatic Repeat Request (ARQ)]]
