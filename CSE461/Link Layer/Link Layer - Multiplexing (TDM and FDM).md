# Link Layer: Multiplexing (TDM and FDM)

## Low-Level Primer: Static Resource Allocation
**Multiplexing** is the process of dividing a single physical resource (a cable or a frequency band) among multiple users or flows. In static multiplexing, the resource is partitioned into fixed units that are assigned to users regardless of whether they have data to send. This is in contrast to **Statistical Multiplexing**, where resources are allocated dynamically based on demand (used in packet-switched networks like the Internet).

---

## 1. Time Division Multiplexing (TDM)

### Mechanism
Users take turns using the **entire bandwidth** of the channel for a specific, fixed time slot.
*   **Structure**: Time is divided into frames, and each frame is divided into $N$ slots (one for each user).
*   **User Experience**: A user sends at the maximum possible rate during their slot and remains silent for the rest of the frame.

### Performance
*   **Throughput per User**: $\frac{1}{N} \cdot B \log_2(1 + \frac{S}{N})$
*   **Characteristics**: Well-suited for synchronous, constant-bitrate traffic (e.g., legacy voice calls).
*   **Issue (Jitter)**: If the number of users $N$ is large, the time between a user's slots increases, leading to potential jitter in real-time applications.

[Image: Diagram showing TDM slots within a repeating frame]

---

## 2. Frequency Division Multiplexing (FDM)

### Mechanism
The total bandwidth $B$ is divided into $N$ smaller frequency bands, each assigned to a specific user.
*   **Structure**: Users transmit simultaneously, but on different frequencies.
*   **Guard Bands**: Small unused frequency gaps between channels to prevent interference.

### Performance
*   **Throughput per User**: $\frac{B}{N} \log_2(1 + \frac{S}{N})$
*   **Characteristics**: Native to analog systems like Radio, TV, and first-generation cellular.

[Image: Diagram showing FDM spectrum with guard bands]

---

## 3. The TDM vs. FDM Throughput Equivalence

Mathematically, both TDM and FDM provide the **exact same per-user throughput**. They simply divide different dimensions of the resource:

*   **TDM**: Divides **Time** (Full $B$, used $1/N$ of the time).
*   **FDM**: Divides **Frequency** ($B/N$ bandwidth, used all of the time).

$$\text{TDM Throughput} = \frac{1}{N} \cdot B \log_2(1 + \frac{S}{N})$$
$$\text{FDM Throughput} = \frac{B}{N} \log_2(1 + \frac{S}{N})$$

---

## 4. Statistical Multiplexing

While TDM/FDM are efficient for predictable, steady traffic, they are highly inefficient for **Bursty Traffic** (like web browsing).

### The Problem with Static Allocation
If a user is assigned a slot (TDM) or a frequency (FDM) but has no data to send, that resource is **wasted**. Other users cannot use it, even if they are overloaded.

### The Packet-Switching Solution
**Statistical Multiplexing** allows nodes to send whenever they have data, using the full capacity of the link. 
*   **Mechanism**: Data is encapsulated into packets and buffered in router queues.
*   **Efficiency**: Dramatically higher utilization for bursty data because users "share" the idle time of others.
*   **Trade-off**: Introduces **Queuing Delay** and the risk of **Packet Loss** if the buffer overflows.

[Image: Comparison graph showing link utilization for TDM vs. Statistical Multiplexing]
