# Physical Layer & Performance

The **Physical Layer** (Layer 1) is the lowest level of the network stack, responsible for the transmission of raw bitstreams over a physical medium. It manages the hardware-level conversion of digital data into electromagnetic, optical, or acoustic signals.

## Low-Level Primer: Performance Metrics
Performance is characterized by how much data can be sent, how fast it travels, and how much is "in flight."

### 1. Latency (Total Delay)
The time taken for a message to travel from source to destination.
$$\text{Latency} = \text{Propagation Delay} + \text{Transmission Delay} + \text{Queuing Delay}$$
*   **Propagation Delay**: The time for one bit to traverse the medium.
    *   $\text{Delay}_{prop} = \frac{\text{Distance}}{\text{Speed of Signal}}$
    *   Speed in copper/fiber is typically $\approx \frac{2}{3}c$ (speed of light).
*   **Transmission Delay**: The time to push all bits of a message onto the link.
    *   $\text{Delay}_{trans} = \frac{\text{Message Size (bits)}}{\text{Bandwidth (bps)}}$
*   **Queuing Delay**: Time spent waiting in [[Router]] buffers for an available output port.

### 2. Throughput & Bandwidth
*   **Bandwidth**: The theoretical maximum rate of the link (the "width" of the pipe).
*   **Throughput**: The actual measured rate of successful data delivery.
*   **Utilization**: The fraction of the link capacity used.
    *   **Stop-and-Wait $U$**: $\frac{\text{Delay}_{trans}}{\text{Delay}_{trans} + RTT}$

### 3. Bandwidth-Delay Product (BDP)
Represents the "volume" of the link—the maximum number of bits that can be in transit simultaneously.
$$\text{BDP} = \text{Bandwidth} \times \text{Round-Trip Time (RTT)}$$
*   **Why it matters**: To keep a high-speed, long-distance ("Long Fat Pipe") link full, the sender's window size must be at least the BDP.

---

## Transmission Media

### 1. Guided Media (Wired)
*   **Twisted Pair (UTP/STP)**: Copper wires twisted to reduce electromagnetic interference (EMI). Standard for Ethernet (Cat5e/6).
*   **Coaxial Cable**: Central conductor surrounded by shielding. High bandwidth over medium distances.
*   **Fiber Optics**: Transmits pulses of light. 
    *   **Multi-mode**: Light bounces at various angles; used for short distances (LANs).
    *   **Single-mode**: Light follows a single path; used for long-haul backbones.
    *   **WDM (Wavelength Division Multiplexing)**: Sending multiple independent streams of data over a single fiber by using different light frequencies.

### 2. Unguided Media (Wireless)
*   **Radio / Microwave**: Omnidirectional or directional transmission. Subject to multi-path fading and interference.
*   **License-Exempt Bands**: Common frequencies (2.4 GHz, 5 GHz) used by WiFi and Bluetooth.

## Link Types
*   **Simplex**: One-way only.
*   **Half-Duplex**: Two-way, but only one side can transmit at a time.
*   **Full-Duplex**: Simultaneous two-way transmission.

## Related Topics
*   **[[Nyquist Limit]]**: Theoretical capacity of noiseless links.
*   **[[Shannon Capacity]]**: Practical capacity of noisy links.
*   **[[Link Layer]]**: The layer that organizes these bits into frames.
