# Variables
- M = message size (bits)
- R = rate (bits/sec)
- D = propagation delay (seconds)
- L = link length (meters)
- C = speed of light ≈ $3 \times 10^8$ m/s

# Latency Formula
$$\text{Latency} = \text{Transmission Delay} + \text{Propagation Delay} = \frac{M}{R} + D$$

## Transmission Delay
- Time to put M-bit message "on the wire"
- $$T_{delay} = \frac{M}{R} \text{ seconds}$$
- Depends on message size and link speed
- Example: 1 KB over 1 Mbps = $\frac{8000}{10^6}$ = 8 ms

## Propagation Delay
- Time for bits to travel across the wire
- $$P_{delay} = \frac{L}{\text{speed of signal}} = \frac{L}{\frac{2}{3}C} = D$$
- Speed in copper/fiber ≈ $2 \times 10^8$ m/s (2/3 speed of light)
- Example: 1000 km link = $\frac{10^6}{2 \times 10^8}$ = 5 ms

# Which Dominates?
| Scenario | Dominant Delay |
|----------|----------------|
| Small message, long distance | Propagation |
| Large message, short distance | Transmission |
| LAN (local) | Usually transmission |
| WAN (cross-country) | Usually propagation |

# Queuing Delay (additional)
In practice, packets may wait in router queues:
$$\text{Total Delay} = T_{trans} + T_{prop} + T_{queue} + T_{processing}$$

# Related
- [[Rate]]
- [[Delay]]
- [[Simple Link Model]]
- [[Bandwidth-Delay Product]]