# Congestion

Congestion is essentially a **traffic jam** for data. It occurs when too many packets are sent through a network node (like a [[Router]] or [[Switch]]) faster than they can be transmitted out. This leads to long queues, increased latency, and eventually packet loss.

## Why is it a problem?
When a router's buffers overflow, it must drop packets. For a reliable protocol like [[Transmission Control Protocol (TCP)|TCP]], this triggers retransmissions. If the network is already overwhelmed, these retransmissions only add to the "jam," potentially leading to **Congestion Collapse**—a state where the network is so busy sending and re-sending data that almost no new data actually gets through.

## Core Concepts
- **[[Resource Allocation]]**: The high-level strategies the network uses to decide who gets to use the [[Link|link]] bandwidth and when.
- **[[Queuing]]**: The actual mechanism inside a router that manages memory buffers for packets waiting to be sent.
- **[[Round-Trip Time (RTT)]]**: A critical metric for congestion, as increasing RTT often signals that router buffers are starting to fill up.

## Measuring Performance
- **Throughput**: How many bits per second are actually making it through.
- **Delay (Latency)**: How long it takes for a packet to cross the network.
- **[[Power]]**: A combined metric calculated as $Throughput / Delay$. Designers aim to operate at the "peak" of the power curve to maximize efficiency without causing long delays.
- **[[Jain's Fairness Index]]**: A mathematical way to check if all users are getting a "fair" share of the network.

## The Taxonomy of Solutions
Congestion can be handled in several ways:
1. **[[Transmission Control Protocol (TCP)#Congestion Control|Host-Based (TCP)]]**: The endpoints slow down when they notice loss.
2. **[[Advanced Congestion Control#Active Queue Management (AQM)|Router-Assisted (AQM)]]**: Routers drop packets early or "mark" them to warn hosts of incoming congestion (e.g., [[RED]], [[ECN]]).
3. **[[Quality of Service (QoS)]]**: Reservations or priorities for specific types of traffic (e.g., video conferencing vs. background downloads).

## Related Topics
- [[Flow Control]] — Keeping a fast sender from overwhelming a slow *receiver* (distinct from congestion).
- [[Forwarding]] — The act of moving packets through the network.
- [[Multiplexing]] — How multiple flows share a single physical link.
