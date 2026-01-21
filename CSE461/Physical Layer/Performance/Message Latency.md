# Variables
- M = message size (bits)
- R = rate (bits/sec)
- D = propagation delay (seconds)
- L = link length (meters)
- C = speed of light ≈ $3 \times 10^8$ m/s

# Latency Formula
$$\text{Latency} = \text{Transmission Delay} + \text{Propagation Delay} = \frac{M}{R} + D$$

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
