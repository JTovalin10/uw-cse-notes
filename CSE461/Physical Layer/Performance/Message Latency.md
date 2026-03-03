# Message Latency

## Variables

- **M** = message size (bits)
- **R** = rate (bits/sec)
- **Propagation delay** (seconds) — distance / speed of light
- **Transmission delay** — size / bandwidth
- **Queuing delay** — how long data has to wait until its turn to be transmitted

## Latency Formula

$$\text{Latency} = \text{Transmission Delay} + \text{Propagation Delay} + \text{Queuing Delay}$$
**Note:** Account for edge cases; this formula is for one packet — multiply by n for multiple packets.
- ACK set up
- if the data is sent continuously or you must wait for ACK
- if you are sending m data at a time
## Transmission Delay
[[MessageLatencyComponents/Transmission Delay]]

## Propagation Delay
[[MessageLatencyComponents/Propagation Delay]]

# Which Dominates?
| Scenario | Dominant Delay |
|----------|----------------|
| Small message, long distance | Propagation |
| Large message, short distance | Transmission |
| LAN (local) | Usually transmission |
| WAN (cross-country) | Usually propagation |

# Queuing Delay (additional)
[[MessageLatencyComponents/Queuing Delay]]

# Related
- [[Rate]]
- [[Delay]]
- [[Simple Link Model]]
- [[Bandwidth-Delay Product]]
