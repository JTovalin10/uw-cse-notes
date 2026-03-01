Traceroute repurposes [[Time to Live (TTL)]] and [[Internet Control Message Protocol (ICMP)]] to discover the path to a destination.

## Mechanism

- Send probe packets with **TTL = 1** → first router decrements to 0, discards, sends ICMP "Time Exceeded" → we learn hop 1
- Send with **TTL = 2** → second router sends ICMP → we learn hop 2
- Repeat, incrementing TTL each time, until we reach the destination (or hit max hops)
- Each router's identity comes from the ICMP reply's source address

![[Pasted image 20260218211500.png]]