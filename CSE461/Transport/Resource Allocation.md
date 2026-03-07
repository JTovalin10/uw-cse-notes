# Resource Allocation

Resource allocation is the "policy" side of network management. It is the process of meeting competing demands for limited network resources: **[[Link]] bandwidth** and **[[Router]] buffer space**.

## The Problem
Since it is rarely possible to give every application all the bandwidth it wants, the network must decide:
1. When to say "no" to a new request.
2. How to "share the pain" when the network is overloaded.
3. How to ensure fairness between different users.

## How do we classify allocation schemes?

### 1. Router-Centric vs. Host-Centric
- **Router-Centric**: The network nodes (routers/switches) are in charge. They decide which packets to drop and tell the hosts how fast they can send.
- **Host-Centric**: The end hosts (running protocols like [[Transmission Control Protocol (TCP)|TCP]]) observe the network and adjust their own behavior.

### 2. Reservation-Based vs. Feedback-Based
- **Reservation-Based**: You ask for bandwidth *before* you start sending (like a phone call). Routers perform **[[Admission Control]]** to see if they have enough room.
- **Feedback-Based**: You start sending and then adjust based on "feedback" from the network.
  - **Explicit**: The router sends a specific signal (e.g., [[ECN]]).
  - **Implicit**: The host guesses there is a problem based on packet loss or [[Round-Trip Time (RTT)]] increases.

### 3. Window-Based vs. Rate-Based
- **Window-Based**: The sender is limited by a "window" of unacknowledged data. This is how [[Sliding Window Protocol|Sliding Windows]] work.
- **Rate-Based**: The sender is told exactly how many bits per second (bps) they can send.

## Evaluation Criteria (Is it "Good"?)

### The Power Metric
Network designers want to maximize **Throughput** while minimizing **Delay**.
- **Power = Throughput / Delay**
- As load increases, throughput goes up, but delay stays low until the queues start to fill. At that point, delay spikes. The "peak" of the Power curve is the optimal operating point.

### Fairness
If two flows are competing, they should ideally get an equal share.
- **[[Jain's Fairness Index]]**: A formula used to quantify this. If all $n$ flows get the same, the index is $1$. If one gets everything, the index is $1/n$.

## Related Topics
- [[Congestion]] — The state that results when resource allocation fails.
- [[Quality of Service (QoS)]] — Advanced allocation for specific guarantees.
- [[Forwarding Table]] — How the router knows where to send the packets it *does* allocate resources to.
