# Bandwidth and Latency
- **Distance** — length of the wire/medium the data travels over
- **Size** — size of the packet
- **Bandwidth** — rate at which the packet is transmitted

NOTE: if a packet contains only one bit on a single link, transmit and queue delays don't matter.

# Networking Latency Cheat Sheet

## Core Formulas

| Term | Formula |
|------|---------|
| **Latency** | propagation + transmit + queue |
| **Propagation** | distance / speed of light |
| | RTT / 2 (if given RTT) |
| **Transmit** | size / bandwidth |

---

## Throughput & Utilization

| Term | Formula |
|------|---------|
| **Throughput** | data_sent / total_time |
| **Bandwidth-Delay Product** | bandwidth × RTT |
| **Utilization (stop-and-wait)** | transmit / (transmit + RTT) |
| **Utilization (windowed)** | (W × transmit) / (transmit + RTT), capped at 1 |

---

## Transfer Modes

**Stop-and-Wait:**
```
time_per_packet = transmit + RTT
total_time = num_packets × (transmit + RTT)
```

**Continuous/Pipelined:**
```
total_time = handshake + transmit_all + propagation
```

---

## Unit Traps

- 1 KB = 1000 bytes (networking) vs 1024 bytes (check your prof)
- 1 Mbps = 10⁶ bits/sec
- Bytes → bits: multiply by 8

# Delay × Bandwidth Product
The volume of the network pipe — gives the **max number of bits in transit** at any instant.

Ex: 50 ms one-way latency, 45 Mbps bandwidth:
$$
50 \times 10^{-3} \times 45 \times 10^6 \text{ bits/sec}
$$

This matters for high-performance networks: it's how many bits the sender must transmit before the first bit arrives at the receiver.

# High-Speed Networks
```
throughput = transfersize / transfertime

transfertime = RTT + 1/bandwidth × transfersize
```
