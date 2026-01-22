The more bandwith, the more data can be transferred and further (think shouting vs whispering)
# Formula
$$BD = R \times D$$

Where:
- R = rate (bits/sec)
- D = propagation delay (seconds)
- BD = bandwidth-delay product (bits)

# What It Represents
- The amount of data "in flight" on the link at any moment
- Think of it as the "volume" of the pipe
- Measured in bits (or messages/packets)

# Examples
| Link Type | Rate | Delay | BD Product |
|-----------|------|-------|------------|
| LAN (100m) | 100 Mbps | 0.5 μs | 50 bits |
| Cross-country | 100 Mbps | 50 ms | 5 Mbit |
| Satellite | 10 Mbps | 250 ms | 2.5 Mbit |

# Why It Matters
- **Small BD (LAN)**: can send and get ACK quickly, simple protocols work
- **Large BD ("long fat pipes")**: lots of data in flight, need careful flow control
- For reliable transfer: sender must be able to buffer at least BD worth of data

# Related
- [[Bandwidth-Delay Product]]
- [[Rate]]
- [[Delay]]