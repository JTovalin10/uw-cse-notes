# Multiple Access & Wireless Mechanics

**Multiple Access** (or **Media Access Control, MAC**) schemes manage how multiple nodes share a single physical medium (wires or radio spectrum). The goal is to maximize **Statistical Multiplexing** gains while minimizing **Collisions**.

## Low-Level Primer: The Two MAC Paradigms
1.  **Centralized (Scheduled)**: A master controller (e.g., a Cellular Base Station) assigns specific time/frequency slots to users.
2.  **Distributed (Contention)**: Nodes compete for access and resolve collisions locally (e.g., Ethernet, WiFi).

---

## Contention-Based Protocols

### 1. ALOHA
The simplest random access protocol.
*   **Pure ALOHA**: A node transmits immediately when it has data. If an ACK isn't received, it retransmits after a random delay.
    *   **Max Throughput**: 18.4%.
*   **Slotted ALOHA**: Time is divided into discrete slots. Nodes only start transmission at the beginning of a slot.
    *   **Max Throughput**: 36.8%.

### 2. CSMA (Carrier Sense Multiple Access)
Nodes "listen" to the medium before transmitting (**Carrier Sense**).
*   **Non-Persistent**: If busy, wait a random time and try again.
*   **1-Persistent (Ethernet)**: If busy, wait until idle and transmit immediately.
*   **p-Persistent**: If busy, wait until idle and transmit with probability $p$.

### 3. Collision Detection (CSMA/CD)
Used in wired Ethernet. Nodes listen *while* transmitting.
*   **Mechanism**: If a collision is detected, the node stops transmitting immediately and sends a **32-bit Jamming Sequence**.
*   **Binary Exponential Backoff (BEB)**: After the $n$-th collision, the node waits for $k \times 51.2\mu s$, where $k$ is a random integer in $[0, 2^n - 1]$.
*   **The 2D Constraint**: To ensure a sender is still transmitting when a collision signal returns from the furthest node, the minimum frame size must be at least $2 \times \text{Propagation Delay}$. (Ethernet min frame = 64 bytes).

---

## Wireless Complications (802.11)

Wireless nodes cannot hear while sending (transmitter power swamps receiver) and thus cannot use CSMA/CD.

### 1. Hidden Terminal Problem
Node A and C can both reach B, but not each other. They may both transmit to B simultaneously, causing a collision at B that neither A nor C can detect.
[Image: Hidden terminal diagram with nodes A, B, and C]

### 2. Exposed Terminal Problem
Node B is sending to A. Node C (within range of B) wants to send to D. C hears B and incorrectly defers, even though C's transmission to D would not interfere with A's reception.
[Image: Exposed terminal diagram showing B-A and C-D paths]

### 3. Collision Avoidance (CSMA/CA)
WiFi uses an **RTS/CTS** (Request to Send / Clear to Send) handshake to "reserve" the medium and solve the hidden terminal problem.
1.  Sender sends **RTS**.
2.  Receiver replies with **CTS**.
3.  Any node hearing the CTS knows someone is about to transmit and sets their **NAV** (Network Allocation Vector) timer to defer.

---

## Reservation-Based Access (LTE/5G)

### OFDMA (Orthogonal Frequency-Division Multiple Access)
The spectrum is viewed as a **2D Resource Grid** of Time and Frequency.
*   **Subcarriers**: The total bandwidth is split into many narrow, orthogonal frequencies (e.g., 15 kHz).
*   **Resource Element (RE)**: The smallest unit (1 subcarrier $\times$ 1 symbol duration).
*   **Physical Resource Block (PRB)**: The scheduling granularity (12 subcarriers $\times$ 7 symbols).
*   **CQI (Channel Quality Indicator)**: UEs provide feedback on signal quality, allowing the base station to adapt modulation (QPSK, 16-QAM, 64-QAM).

---

## Personal Area Networks: Bluetooth
*   **Piconet**: 1 Master and up to 7 Slaves.
*   **Frequency Hopping**: Hops across 79 channels every 625 $\mu s$ to avoid interference.
*   **Time Division**: Master transmits in odd slots; slaves only respond in even slots.
*   **Parked State**: Slaves can be put in low-power "Parked" mode (up to 255 per piconet).

[Image: Bluetooth piconet master-slave topology]
