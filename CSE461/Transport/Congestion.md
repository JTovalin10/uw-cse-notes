# Congestion
A "traffic jam" in the network where input rate > output rate persistently.

## Core Concepts
- [[Resource Allocation]]: Terminology, Network Models, and Taxonomy.
- [[Queuing Disciplines]]: How routers handle buffers (FIFO, FQ, WFQ).

## Mechanisms
- [[TCP Congestion Control]]: AIMD, Slow Start, Fast Retransmit, and CUBIC.
- [[Advanced Congestion Control]]: AQM (RED, ECN) and Delay-based CC (Vegas, BBR).
- [[Quality of Service (QoS)]]: RSVP, IntServ, and DiffServ for real-time traffic.

## Effects of Congestion
- Delay and loss rise sharply.
- **Congestion Collapse**: Exponential drop in goodput under heavy load.
- **Power**: Throughput / Delay (Efficiency metric).

![Congestion Performance](https://book.systemsapproach.org/_images/f06-03-9780123850591.png)
