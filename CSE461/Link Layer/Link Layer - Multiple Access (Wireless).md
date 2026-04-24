# Link Layer: Multiple Access (Wireless)

## Low-Level Primer: Wireless Complications
Wireless multiple access is significantly more complex than wired (Ethernet) for three primary reasons:
1.  **Half-Duplex Nature**: Radios cannot transmit and receive on the same frequency simultaneously. This means **[[CSMA-CD (Collision Detection)]]** is impossible; a node cannot hear a collision while it is sending.
2.  **Signal Fading**: Signal strength drops rapidly with distance ($1/r^2$ or more), meaning not all nodes can hear each other.
3.  **Interference**: External noise and non-network devices (microwaves, Bluetooth) compete for the same spectrum.

---

## 1. The Terminal Problems

### The Hidden Terminal Problem
*   **Scenario**: Node A can hear B, and Node C can hear B, but A and C cannot hear each other.
*   **The Problem**: A starts sending to B. C senses the medium, hears "idle" (because it can't hear A), and also starts sending to B. A and C's signals **collide at B**, rendering both transmissions useless.
*   **Result**: Carrier Sense fails to prevent collisions.

### The Exposed Terminal Problem
*   **Scenario**: B is sending to A. C wants to send to D. C can hear B, but B cannot hear D.
*   **The Problem**: C senses the medium, hears B is busy, and defers its transmission to D. However, C's transmission to D would *not* have interfered with A's reception from B.
*   **Result**: Carrier Sense prevents concurrent, non-interfering transmissions, reducing throughput.

---

## 2. CSMA/CA (Collision Avoidance)

Because nodes cannot detect collisions, they must work to avoid them entirely.

### The RTS/CTS Handshake
To solve the Hidden Terminal problem, nodes use a virtual carrier sensing mechanism:
1.  **RTS (Request to Send)**: Sender (A) sends a short frame to the receiver (B) containing the requested duration of the transmission.
2.  **CTS (Clear to Send)**: If B is free, it broadcasts a CTS frame.
    *   **Effect**: Any node that can hear A hears the RTS; any node that can hear B hears the CTS.
    *   **The Fix**: Node C (hidden from A) hears the CTS from B and knows to remain silent for the duration specified in the frame.

### MACAW and Inter-Frame Spacing
802.11 uses precise timing to coordinate access:
*   **SIFS (Short Inter-Frame Space)**: Used for high-priority ACKs and CTS.
*   **DIFS (Distributed Inter-Frame Space)**: The minimum time a node must wait after the medium becomes idle before sensing again.
*   **NAV (Network Allocation Vector)**: A local timer at each node that tracks how long the medium is reserved by other nodes (based on RTS/CTS info).

---

## 3. Wi-Fi (IEEE 802.11)

### Physical Layer Properties
*   **ISM Bands**: Operates in unlicensed 2.4 GHz and 5 GHz bands.
*   **Modulation**: Uses **OFDM** (Orthogonal Frequency Division Multiplexing) to handle multipath fading.
*   **[[MIMO]] (Multiple Input Multiple Output)**: Uses multiple antennas to increase throughput via spatial multiplexing (sending different data streams on different antennas).

### Reliability
Because wireless is lossy, the 802.11 Link Layer uses **Immediate ACKs**. If an ACK is not received, the frame is retransmitted at the link layer, hiding the loss from the higher-layer TCP protocol.

---

## 4. Centralized MAC (Cellular / GSM)

Unlike the decentralized Wi-Fi model, cellular networks (GSM, LTE, 5G) use **Centralized Control**.

### Mechanics
*   **Base Station (BS) / eNodeB**: The BS acts as the "Referee," dictating exactly when each **User Equipment (UE)** can transmit.
*   **Spectrum Scarcity**: Because spectrum is licensed and expensive, cellular protocols are highly efficient, avoiding the overhead of "contention" and "collisions" found in Wi-Fi.
*   **TDM/FDM Hybrid**:
    *   The BS divides the spectrum into frequency bands (FDM).
    *   Within each band, it assigns users specific time slots (TDM).
*   **[[Quality of Service (QoS)]]**: Centralized scheduling allows for guaranteed bitrates, essential for voice calls.
