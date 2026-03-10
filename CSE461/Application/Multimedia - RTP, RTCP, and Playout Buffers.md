# Multimedia Applications: RTP, RTCP, and Playout Buffers

**Multimedia Applications** (e.g., VoIP, IPTV) are defined by **Isochronous** traffic patterns, where data must be delivered with consistent timing.

---

## Low-Level Primer: Real-Time Challenges

*   **Jitter**: Variance in the inter-arrival time of packets.
*   **[[Playout Buffer]]**: A client-side buffer used to smooth out jitter by delaying playback until a steady stream is available.
*   **Isochronous**: Data that requires a constant bit rate and strict timing for playback.
*   **[[Codecs]]**: Algorithms like **G.711** (voice) or **H.264** (video) that compress analog signals into digital streams.

---

## Transport Protocols for Real-Time

### [[RTP]]: Real-Time Transport Protocol
*   **Function**: Provides **Sequence Numbers** (for loss detection) and **Timestamps** (to remove jitter).
*   **Note**: RTP does *not* provide reliability; it only provides the metadata needed to reconstruct the stream.

### [[RTCP]]: Real-Time Control Protocol
*   **Function**: Provides QoS feedback (loss rate, delay) to the sender.
*   **Benefit**: Enables **Adaptive Encoding**, where the sender can lower the bitrate if the network is congested.

---

## Resource Allocation

### [[DiffServ]]: Differentiated Services
*   Uses the **DSCP** field in the IP header to prioritize traffic.
*   **Expedited Forwarding (EF)**: Used for low-latency media streams.
*   **Assured Forwarding (AF)**: Used for critical signaling traffic.

![[Pasted image 202603061.01.13 PM.png]]
*Figure: DiffServ applied to a VoIP application*
