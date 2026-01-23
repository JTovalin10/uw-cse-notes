# Bandwidth and Latency
distance = length over the wire over which data will travel
size = size of packet
bandwidth = bandwidth at which the packet is transmitted
NOTE: if packet only contains one bit and its a single link, then trasmit and queue dont matter

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
# Delay x Bandwidth Product
to find the volume of the network pipe we can measure it with delay x bandwidth product, which gives us the max number of bits that could be in transit through the pipe at any given instance
Ex:
one way latency of 50ms and a bandwidth of 45 Mbps
$$
50 \times 10^{-3} \times 45 \times 10^6 \text{bits/sec}
$$
this is important to know when making high-performance networks as it corresponds to how many bits the sender must ransmit before the fitst bit arrives at the reciever

# High-speed networks
```
throughput = transfersize / transfertime

transfertime = RTT + 1/bandwidth x transfersize\
```