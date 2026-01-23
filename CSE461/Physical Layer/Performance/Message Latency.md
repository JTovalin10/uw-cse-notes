# Variables
- M = message size (bits)
- R = rate (bits/sec)
- propagation delay (seconds)
	- distance / speed of light
- Transmit delay
	- size / bandwidth
- Queue
	- ho long data has to wait until its their turn to be transmitted

# Latency Formula
$$\text{Latency} = \text{Transmission Delay} + \text{Propagation Delay} + Queue$$

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
