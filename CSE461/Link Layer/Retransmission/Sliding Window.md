Generalization of [[Stop-and-Wait]]
- allows W frames to be outstanding
- can send W frames per RTT
- various options for numbering frames/ACKs and handling loss

## Textbook Notes

Allows multiple frames to be in flight simultaneously, keeping the pipe full.

![[Pasted image 20260207013628.png]]

### Sender Side
The sender assigns a sequence number to each frame and maintains:
- **SWS** (Send Window Size) — max outstanding frames
- **LAR** (Last ACK Received) — sequence number of last acknowledged frame
- **LFS** (Last Frame Sent) — sequence number of last frame sent

Invariant:
```
LFS - LAR <= SWS
```

When an ACK arrives, LAR advances, allowing the sender to transmit another frame. Each frame has a timer — if it expires before an ACK arrives, the frame is retransmitted. The sender must buffer up to SWS frames for potential retransmission.

![[Pasted image 20260207013610.png]]

### Receiver Side
The receiver maintains:
- **RWS** (Receive Window Size) — max out-of-order frames it will accept
- **LAF** (Largest Acceptable Frame) — sequence number of the largest acceptable frame
- **LFR** (Last Frame Received) — sequence number of the last frame received

Invariant:
```
LAF - LFR <= RWS
```

When a frame with sequence number `SeqNum` arrives:
1. `SeqNum <= LFR` or `SeqNum > LAF` → **discard**
2. `LFR < SeqNum <= LAF` → **accept** (within window)
3. Find the largest `SeqNumToAck` such that all frames up to it have been received → send **cumulative ACK** for `SeqNumToAck`
4. Set `LFR = SeqNumToAck`, `LAF = LFR + RWS`

### Problem: Pipe Drain on Loss
When a timeout occurs, the sender can't advance its window until the lost frame is acknowledged. Data in transit decreases and the pipe is no longer full. The longer it takes to notice a loss, the worse this gets.

### Finite Sequence Numbers
Sequence numbers can't grow forever. The number of possible sequence numbers must be larger than the number of outstanding frames. When `RWS = SWS`:
```
SWS < (MaxSeqNum + 1) / 2
```