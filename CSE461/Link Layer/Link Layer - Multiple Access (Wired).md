# Link Layer: Multiple Access (Wired)

## Low-Level Primer: The Shared Medium
In a **Shared Medium** network (e.g., a single coaxial cable or a wireless frequency), multiple nodes compete for access to the same physical channel. Without a coordination mechanism, simultaneous transmissions result in **Collisions**, where the electrical or radio signals interfere, rendering the data unreadable. **Multiple Access** protocols define the rules for how nodes "take turns" to maximize throughput and minimize collisions.

---

## 1. ALOHA Protocol (The Foundation)

Developed at the University of Hawaii, ALOHA is the simplest decentralized multiple access protocol.

### Pure ALOHA
*   **Mechanism**: A node transmits immediately whenever it has data. If it doesn't receive an **[[Acknowledgment (ACK)]]** within a timeout, it assumes a collision occurred, waits a random time, and resends.
*   **Vulnerability Window**: $2 \times T$ (where $T$ is the frame transmission time). A frame is vulnerable to any other transmission starting $T$ before or $T$ after its own start.
*   **Max Throughput**: $\approx 18.4\%$.

### Slotted ALOHA
*   **Mechanism**: Time is divided into discrete slots equal to $T$. Nodes can only start transmitting at the beginning of a slot.
*   **Vulnerability Window**: Reduced to $1 \times T$.
*   **Max Throughput**: $\approx 36.8\%$.

---

## 2. CSMA (Carrier Sense Multiple Access)

**[[Carrier Sense Multiple Access (CSMA)|CSMA]]** improves on ALOHA by requiring nodes to "listen before they talk" (**Carrier Sense**).

### Persistence Strategies
*   **1-Persistent**: If the medium is idle, transmit immediately (probability 1). If busy, wait until idle and then transmit.
*   **Non-Persistent**: If busy, wait a random time before sensing again.
*   **p-Persistent**: If idle, transmit with probability $p$.

### The Collision Problem in CSMA
Even with carrier sense, collisions occur due to **Propagation Delay**. Node A starts transmitting, but the signal hasn't reached Node B yet. Node B senses "idle" and starts its own transmission, causing a collision at a point between them.

---

## 3. CSMA/CD (Collision Detection)

Used in **Classic Ethernet**, CSMA/CD improves efficiency by allowing nodes to detect a collision *while* transmitting.

### Mechanics
1.  **Listen while Talking**: If the electrical signal on the wire differs from what the node is driving, a collision is detected.
2.  **Jamming**: The node immediately aborts the transmission and sends a **32-bit Jam Signal** to ensure all other nodes also detect the collision.
3.  **Minimum Frame Size**: To ensure a sender is still transmitting when a collision signal returns from the furthest point in the network, the frame must be at least $2 \times \text{Propagation Delay}$ ($2D$).
    *   **Ethernet Standard**: 64 Bytes (512 bits) minimum frame size.

---

## 4. Binary Exponential Backoff (BEB)

When a collision occurs, nodes must wait before retrying. **BEB** dynamically adjusts the waiting time based on network congestion.

### The Algorithm
1.  After the $n$-th collision, the node chooses a random number $k$ from the range $[0, 2^n - 1]$.
2.  The node waits $k \times \text{SlotTime}$ (51.2 $\mu s$ for 10Mbps Ethernet) before re-sensing the medium.
3.  **Exponential Growth**: The range doubles with each collision ($n=1 \to [0,1]$; $n=2 \to [0,3]$; $n=3 \to [0,7]$).
4.  **Capping**: The range is usually capped at $n=10$ ($1023$ slots). After 16 failed attempts, the frame is discarded.

---

## 5. Classic Ethernet (IEEE 802.3)

### Physical Properties
*   **Bus Topology**: All nodes attached to a single segment (10Base5 or 10Base2).
*   **Repeaters**: Used to extend the length of the segment, but they increase the **Collision Domain**.
*   **Transceiver**: The hardware that detects idle/busy states and drives signals.

### Frame Format
| Field | Size | Description |
| :--- | :--- | :--- |
| **Preamble** | 8 Bytes | Clock synchronization. |
| **Dest/Src Addr** | 6 Bytes each | 48-bit globally unique MAC addresses. |
| **Type** | 2 Bytes | Demultiplexing key (e.g., IPv4). |
| **Payload** | 46–1500 Bytes | Minimum 46B + 18B header = 64B total. |
| **CRC** | 4 Bytes | Error detection. |
