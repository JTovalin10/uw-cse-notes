# Transport Layer: Resource Allocation and QoS

## Low-Level Primer: The Fairness vs. Efficiency Trade-off
In a congested network, the transport layer must decide how to distribute shared link capacity among competing flows. An ideal allocation is both **Efficient** (fully utilizes the link without creating massive queues) and **Fair** (ensures every flow gets a "reasonable" share).

---

## 1. Defining Fairness: Max-Min Fair Allocation

**Max-Min Fairness** is the standard model for network resource distribution. It prioritizes the flows with the smallest demands.

### The Algorithm (Intuition)
1.  Imagine "pouring water" into the network paths for all flows at an equal rate.
2.  When a flow's path hits a **Bottleneck** link, its rate is frozen.
3.  Continue increasing the rate for all non-frozen flows until they hit their own bottlenecks.
*   **Result**: Every flow gets an equal share of its most constrained link. Increasing the rate of any flow would require decreasing the rate of an already smaller flow.

[Image: Diagram of max-min fairness calculation across a multi-link topology]

---

## 2. Router Queuing Disciplines

The order in which a router processes its buffer significantly impacts fairness and latency.

### FIFO (First-In, First-Out) with Tail Drop
*   **Mechanism**: Packets are sent in arrival order. If the buffer is full, the incoming packet is dropped (**Tail Drop**).
*   **Drawback (Global Synchronization)**: Causes all TCP flows to experience loss simultaneously, leading to synchronized Multiplicative Decreases and poor link utilization.

### Fair Queuing (FQ)
*   **Mechanism**: The router maintains a separate queue for each flow and services them in **Round-Robin** order.
*   **Benefit**: Provides isolation. A "greedy" flow (e.g., UDP blast) only harms its own queue, not the queues of well-behaved TCP flows.
* Issue: flows dont see uncontrolled delay/loss from others
	* but differnet packet sizes lead to bandwidth imbalance
		* might be significant 
* round robin but approx bit-level fariness
	* approx by cpmuting virtual finish line
	* virtual clock ticks once for each bit sent from all flows
	* send packets in order of their virtual finish lines, Finish(k)_F
	* not perfect - dont reemt pacet beign transmitted
		* - Arrive(j)$_F$ = arrival time of j-th packet of flow F
		* length(j)$_F$ = length of j-th pacjet of flow F
		* finish(j)$_F$ = max (Arrive(j)$_F$, Finish(j - 1)$_F$ + length (j)$_F$)
	* we find the finish of each queue and order lowest-to-highest
### Weighted Fair Queuing (WFQ)
- WFQ is a useful generalization of fair queuing
	- assign a weight, weight$_F$, to each flow
	- higher weight gives more bandwidth, e.g., 2 is 2x bandwidth
	- change computation of Finish(j)$_F$ to factor in Weight$_F$
		- Arrive(j)$_F$ = arrival time of j-th packet of flow F
		* length(j)$_F$ = length of j-th pacjet of flow F
		* finish(j)$_F$ = max (Arrive(j)$_F$, Finish(j - 1)$_F$ + length (j)$_F$ / Weight$_F$)

---

## 3. Quality of Service (QoS) Models

When simple fairness is not enough (e.g., for VoIP or VIP traffic), the network uses QoS to prioritize specific packets.

### Differentiated Services (DiffServ)
*   **Mechanism**: Uses the 6-bit **DSCP** (Differentiated Services Code Point) field in the IP header.
*   **Classes**:
    *   **EF (Expedited Forwarding)**: Low-loss, low-latency, low-jitter (used for Voice).
    *   **AF (Assured Forwarding)**: Guaranteed delivery under congestion.
*   **Scalability**: High. Decisions are made hop-by-hop based on the tag; no per-flow state is required in routers.

### Integrated Services (IntServ) and RSVP
*   **Mechanism**: Uses **[[RSVP]]** (Resource Reservation Protocol) to signal routers to reserve a specific amount of bandwidth for a flow.
*   **Scalability**: Low. Every router along the path must maintain state for every individual flow.

---

## 4. Key Metrics

*   **Throughput**: The aggregate data rate achieved.
*   **Goodput**: The rate of useful data delivered to the application (excludes retransmissions and protocol overhead).
*   **Jitter**: The variance in packet inter-arrival time. Critical for **RTP** applications.
