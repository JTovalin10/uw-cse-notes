# ACK Clocking

Each in-order ACK advances the sliding window and lets a new segment enter the network. ACKs effectively "clock" data segments — they determine how fast packets are transmitted into the network.

## Benefits

- Prevents the bottleneck link from creating a buildup of queued packets
- Helps achieve low levels of loss and delay
- The network smooths out bursts of data segments
- ACK clocking transfers this smooth timing back to the sender
- Subsequent data segments are not sent in bursts, so they do not queue up in the network

![[ACK Clocking.png]]

## TCP

[[Transmission Control Protocol (TCP)|TCP]] uses a sliding window partly for the value of ACK clocking:
- The sliding window controls how many segments are in flight
- TCP sends small bursts of segments so the network keeps traffic smooth

## Related

- [[Sliding Window]] — window-based transmission
- [[Transmission Control Protocol (TCP)]] — implements ACK clocking