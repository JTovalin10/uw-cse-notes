# Transport Layer: Real-Time Transport (RTP and RTCP)

## Low-Level Primer: The Timing Problem
Standard transport protocols (TCP/UDP) do not provide timing information. For **Isochronous** data (media where bits must be played back with consistent timing), the receiver needs to know exactly *when* each sample was taken. **[[RTP]]** provides this metadata by adding sequence numbers and timestamps to UDP-based media streams.

---

## 1. Real-Time Transport Protocol (RTP)

RTP is a "Transport-over-Transport" protocol, usually running over **[[User Datagram Protocol (UDP)|UDP]]**.

### RTP Header (12 Bytes Fixed)
*   **Payload Type (PT)**: Identifies the format (e.g., G.711 audio, H.264 video).
*   **Sequence Number**: Used to detect packet loss and restore the original order.
*   **Timestamp**: Represents the sampling instant. The receiver uses this to remove **Jitter** (arrival time variance) via a **[[Playout Buffer]]**.
*   **SSRC (Synchronization Source)**: A random 32-bit ID that uniquely identifies the source of the stream.

---

## 2. Real-Time Control Protocol (RTCP)

RTCP is the companion protocol that provides feedback on the quality of the RTP session. It typically uses the next consecutive UDP port (RTP + 1).

### Core Functions
1.  **QoS Feedback**: Reports packet loss, jitter, and RTT. This allows the sender to perform **Adaptive Encoding** (lowering bitrate during congestion).
2.  **CNAME (Canonical Name)**: Maps the transient SSRC to a permanent user/host ID (e.g., `user@host.com`).
3.  **Inter-media Synchronization**: Solving the **Lip-Sync** problem. RTCP packets map the RTP relative timestamp to an absolute wall-clock time (**NTP**), allowing the receiver to align audio and video streams.

---

## 3. Key Concepts

*   **Mixer**: Combines multiple RTP streams (e.g., a conference call) into a single new stream. It becomes the new SSRC and lists original sources as **CSRC (Contributing Sources)**.
*   **Translator**: Forwards RTP packets across a boundary (e.g., a firewall or a transcoder) without changing the SSRC.
*   **Talkspurt**: A burst of audio data during speech. Playout buffers often adjust their size during silence periods between talkspurts to minimize latency without audible pops.

[Image: Diagram of RTP/RTCP packet flow between two endpoints]
