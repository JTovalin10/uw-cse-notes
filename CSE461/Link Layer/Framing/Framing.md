# What is it
## Problem
the physical layer gives us a stream of bits. How do we interpret it as a sequence of frames
# Methods
- [[Byte Count]] (motivation)
- [[Byte Stuffing]]
- [[Bit Stuffing]]

## Textbook Notes

### Byte-Oriented Protocols (PPP)
One of the oldest approaches to framing, which views each frame as a collection of bytes rather than a collection of bits. There are two approaches to this:
1. **Sentinel characters**: indicate where a frame starts and ends
	1. Denote the beginning of a frame by sending a special SYN character
	2. The data portion of the frame is then contained between two special characters: STX (start of text) and ETX (end of text)
	3. PROBLEM:
		1. The special character might appear in the data portion of the frame
			1. The standard way to overcome this is with an escaped backslash (character stuffing)
2. **Byte counting**: include the number of bytes in the frame at the beginning of the frame (in the frame header)
	1. ISSUES:
		1. A transmission error could corrupt the count field, so the end of the frame would not be correctly detected. This would cause the receiver to accumulate as many bytes as the bad count field indicates and then use the error detection field to determine that the frame is bad (framing error)
		2. The receiver will then wait until it sees the next SYN character to start collecting the bytes that make up the next frame
		3. A frame error can cause back-to-back frames to be incorrectly received

![[Pasted image 20260207001540.png]]
PPP is most commonly used to carry IP packets over various sorts of point-to-point links.

### Bit-Oriented Protocols (HDLC)
Unlike byte-oriented protocols, HDLC is not concerned with byte boundaries and simply views the frame as a collection of bits—the bits can be anything.

HDLC denotes both the beginning and end of a frame with the distinguished bit sequence `01111110`. This sequence can also be transmitted during any idle time on the link so that the sender's and receiver's clocks stay in sync. This is essentially the sentinel approach, since the sequence could appear anywhere in the body of the frame.
![[Pasted image 20260207002308.png]]

#### Protocol
Bit stuffing in the HDLC protocol works as follows. On the sending side, any time five consecutive 1s have been transmitted from the body of the message (i.e., excluding when the sender is trying to transmit the distinguished `01111110` sequence), the sender inserts a 0 before transmitting the next bit. On the receiving side, should five consecutive 1s arrive, the receiver makes its decision based on the next bit it sees (i.e., the bit following the five 1s). If the next bit is a 0, it must have been stuffed, and so the receiver removes it. If the next bit is a 1, then one of two things is true: Either this is the end-of-frame marker or an error has been introduced into the bit stream. By looking at the _next_ bit, the receiver can distinguish between these two cases. If it sees a 0 (i.e., the last 8 bits it has looked at are `01111110`), then it is the end-of-frame marker; if it sees a 1 (i.e., the last 8 bits it has looked at are `01111111`), then there must have been an error and the whole frame is discarded. In the latter case, the receiver has to wait for the next `01111110` before it can start receiving again, and, as a consequence, there is the potential that the receiver will fail to receive two consecutive frames.

### Clock-Based Framing (SONET)
SONET addresses both the framing and encoding problems, as well as the multiplexing of several low-speed links into one high-speed link (useful for phone networks).

#### Approach
- No bit stuffing is used, so a frame's length does not depend on the data being sent
- Uses statistical/probabilistic synchronization

**1. Soft Synchronization**

- The receiver doesn't achieve instant, guaranteed lock on frame boundaries
- Instead, it builds **confidence over time** by observing the pattern repeatedly at 810-byte intervals
- This is fundamentally different from bit-stuffed approaches where boundaries are unambiguous

**2. Tolerance for Ambiguity**

- Since the sync pattern (in those first 2 bytes) _can_ appear randomly in the payload, any single occurrence might be a false positive
- The receiver must distinguish between:
    - **True sync patterns** (actual frame start markers)
    - **False sync patterns** (random data that happens to match)

**3. Trade-offs**

**Advantages:**

- **Fixed frame size** - always exactly 810 bytes, making timing and bandwidth calculations predictable
- **No overhead expansion** - unlike bit stuffing, the frame never grows due to payload content
- **Simpler encoding** - no need to scan and modify payload data

**Disadvantages:**

- **Acquisition time** - takes multiple frames to achieve synchronization (not instant)
- **Potential for loss of sync** - noise or errors could cause the receiver to lose lock
- **Recovery latency** - if sync is lost, must wait to re-acquire it

**4. Practical Implementation**

The receiver typically uses a **state machine** with hysteresis:

- Requires seeing the pattern correctly N times to declare "in sync"
- Tolerates M misses before declaring "out of sync"
- This prevents bouncing between states due to occasional bit errors

This approach works well for SONET because it's designed for high-quality fiber links where bit errors are rare, making false synchronization unlikely.
![[Pasted image 20260207003113.png]]
To ensure plenty of transitions that allow a receiver to recover the sender's clock, the payload bytes are scrambled. This is done by calculating the XOR of the data to be transmitted with a well-known bit pattern (127 bits long with plenty of transitions from 1 to 0). SONET also assumes that the payload for each frame fits completely within the frame, which is an overly simplistic assumption.
