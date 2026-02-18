Continuous Sending (no ACK wait)
```
Total = Handshake + Transmission Time + Propagation
      = (Handshake RTTs × RTT) + (File Size / Bandwidth) + (RTT / 2)
```
Stop and wait (wait for ACK after each packet)
```
Total = Handshake + First (n-1) packets + Last packet
      = (Handshake RTTs × RTT) + (n-1)(Transmit + RTT) + (Transmit + RTT/2)
```
- n = number of packets = File Size / Packet Size
- Transmit = Packet Size / Bandwidth
Note for propagation: Speed of light must be in meters

Width of a bit
```
Bit Width = 1 bit / Bandwidth
```

## Textbook Notes

We want to deliver frames reliably and recover discarded (lost) or corrupted frames.

While reliability can be provided at the link layer, many modern link technologies omit this function and push it up to the application layer.

### Pipe Capacity
```
delay × bandwidth
```
The amount of data that could be in transit at any given time — "keeping the pipe full."

### How We Achieve Reliability
1. **Acknowledgements (ACK)** — a small control frame sent back to confirm receipt of an earlier frame
	- Can be piggybacked on a data frame going in the opposite direction
2. **Timeouts** — if no ACK arrives after a reasonable time, retransmit the original frame

Using both together is called **Automatic Repeat Request (ARQ)**.

### Approaches
The simplest ARQ scheme is [[Stop-and-Wait]] — send one frame, wait for ACK, repeat. It's simple but wastes bandwidth because only one frame can be in flight at a time.

To keep the pipe full, we use a [[Sliding Window]] protocol that allows multiple outstanding frames. This is more complex but dramatically improves throughput. See [[Sliding Window Implementation]] for the C code.

The sliding window can serve three roles:
1. **Reliable delivery** — retransmit lost frames
2. **Preserving order** — don't deliver a frame until all earlier frames have been delivered
3. **Flow control** — the receiver tells the sender how many frames it has room to accept, throttling the sender

### Concurrent Logical Channels
An alternative approach used in the ARPANET datalink protocol. The idea is to multiplex several logical channels onto a single point-to-point link and run [[Stop-and-Wait]] on each channel independently. Implies nothing about flow control since frames aren't kept in any particular order.