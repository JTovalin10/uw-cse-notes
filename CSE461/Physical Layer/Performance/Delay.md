Measured in seconds; related to length.

**Transmission delay** (time to put bits on wire):
$$T_{trans} = \frac{M}{R}$$
where $M$ = message size (bits), $R$ = link rate (bps)

**Propagation delay** (time for signal to travel):
$$T_{prop} = \frac{L}{c}$$
where $L$ = link length, $c$ = propagation speed in the medium (~$2 \times 10^8$ m/s in copper, ~$3 \times 10^8$ m/s in vacuum/fiber)

**Total message latency:**
$$L = \frac{M}{R} + \text{propagation delay}$$

# Related
- [[Rate]]
- [[Message Latency]]
- [[Simple Link Model]]
- [[Bandwidth-Delay Product]]