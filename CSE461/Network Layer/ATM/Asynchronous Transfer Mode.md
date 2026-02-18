![[Pasted image 20260214020718.png]]

A [[Virtual Circuit (VC)]]-based networking technology that uses [[Fixed-Size Cells]] (53 bytes) instead of variable-length packets to enable hardware-based parallel switching.

## Cell Header
The header contains a [[Virtual Path Identifier (VPI)]] and [[Virtual Circuit Identifier (VCI)|VCI]] which combine to 25 bits. Breaking the identifier into two parts creates a level of hierarchy:
- All circuits sharing the same VPI are treated as a group (**virtual path**) and can be switched together
- Switches only need to look at the VPI bits, ignoring all VCI bits — massively reduces [[Forwarding Table|VC table]] size

## Tradeoffs
The fixed cell size is what makes ATM fast — hardware can process identically-sized units in parallel. But it comes at a cost: [[Cell Tax]] means bandwidth is wasted whenever payloads don't fit neatly into 48 bytes.

## Context
ATM is one of several [[Virtual Circuit (VC)]] technologies (along with X.25 and Frame Relay) that were largely replaced by the Internet's [[Connectionless]] model. See [[VC Resource Allocation and QoS]] for how VC networks handle resource guarantees compared to datagrams.
