# Multimedia Applications

**Multimedia Applications** (e.g., VoIP, IPTV, Videoconferencing) are defined by **Isochronous** traffic patterns, where data must be delivered with consistent timing. Unlike traditional data, they exhibit a **Steep Utility Curve**, meaning the application's usefulness collapses rapidly if network performance (loss/delay) exceeds a narrow threshold.

## Low-Level Primer: Real-Time Mechanics
*   **Jitter**: Variance in the inter-arrival time of packets. Compounding jitter leads to audio/video artifacts.
*   **Playout Buffer**: A client-side memory region used to smooth out jitter by delaying playback of initial packets to create a steady stream.
*   **Isochronous**: Data streams that require a constant bit rate and strict timing for playback.
*   **Codecs**: Mathematical algorithms (e.g., **G.711**, **H.261**) that compress analog signals into digital bitstreams. **G.711** (8-kHz sampling, 8 bits/sample) is the standard for telephony.

## Session Control & Call Control
Session control manages the logic of establishing, maintaining, and tearing down communication channels.

### SDP: Session Description Protocol
A text-based (**ASCII**) protocol using `<type>=<value>` pairs to describe session parameters. It is typically encapsulated in **SIP** or **SAP** payloads.
*   **Key Fields**:
    *   `v=`: Protocol version.
    *   `o=`: Origin (username, session ID, version, network type, IP).
    *   `s=`, `i=`, `u=`: Session name, info, and **URI**.
    *   `c=`: **Connection Information** (Network type, Address type, **Multicast Address**).
    *   `t=`: Start and stop times (NTP format).
    *   `m=`: **Media Description** (Format: `<media> <port> <transport> <fmt list>`).
        *   Example: `m=audio 49170 RTP/AVP 0` (Audio on port 49170 via **RTP/AVP**, codec 0).

[Image: Session directory tool displaying information extracted from SDP messages]

### SIP: Session Initiation Protocol
An application-layer request/response protocol (Port **5060/5061**) modeled after HTTP but designed for real-time human interaction.
*   **The Five SIP Categories**:
    1.  **User Location**: Determining which device reaches a specific user.
    2.  **User Availability**: Determining if a user is willing or able to join a session.
    3.  **User Capabilities**: Determining coding schemes and media types (negotiated via SDP).
    4.  **Session Setup**: Establishing port numbers and transport parameters.
    5.  **Session Management**: Functions like call forwarding, session transfer, and parameter modification.
*   **Architecture**:
    *   **User Agent (UA)**: The endpoint (IP phone/software).
    *   **Proxy Server**: Intermediary that routes requests based on URI-to-IP mappings.
    *   **Registrar**: Receives `REGISTER` messages to bind a logical **SIP URI** (e.g., `user@domain`) to a physical **Contact Address**.
    *   **Forking**: The proxy sends a request to multiple devices (in parallel or series) to locate a user.
*   **Core Messages**:
    *   `INVITE`: Initiates a session; contains **SDP** payload.
    *   `180 Ringing`: Provisional response indicating the user is being alerted.
    *   `200 OK`: Positive response; session accepted.
    *   `ACK`: Final handshake; allows media to flow **directly** between peers, bypassing proxies.
    *   `BYE`: Terminates the session.

[Image: Establishing communication through SIP proxies mapping URIs to IP addresses]
[Image: Message flow for a basic SIP session showing INVITE, 100 Trying, 180 Ringing, 200 OK, and ACK]

### H.323
The **ITU-T** standard for multimedia over packet networks.
*   **Components**:
    *   **Terminal**: The endpoint originating/terminating calls.
    *   **Gatekeeper**: Performs address translation and **Admission Control** (bandwidth limiting).
    *   **Gateway**: Bridges H.323 to the **PSTN** (Public Switched Telephone Network).
*   **H.245**: The internal control protocol used for capability exchange and port negotiation (analogous to SDP).

[Image: Devices in an H.323 network including Terminals, Gatekeepers, and Gateways]

## Resource Allocation & QoS
Multimedia often requires dedicated network resources to maintain the steep utility curve.

### Differentiated Services (DiffServ)
*   **DSCP (Differentiated Services Code Point)**: A 6-bit field in the [[IP]] header.
*   **Expedited Forwarding (EF)**: Applied to media packets for low-latency, priority queuing.
*   **Assured Forwarding (AF)**: Applied to signaling (SIP/H.323) to reduce loss risk compared to best-effort traffic.

[Image: DiffServ applied to a VoIP application showing queuing on the upstream link]

### Admission Control Strategies
The process of rejecting calls if bandwidth is insufficient.
*   **Off-Path Admission Control**: Managed by a **SIP Proxy** or **H.323 Gatekeeper**. The control entity is not on the data path and must "guess" path conditions based on topology.
*   **On-Path Admission Control**: Managed by routers along the data path using protocols like **RSVP** ([[Resource Reservation Protocol (RSVP)]]).

[Image: Admission control using a session control protocol (Proxy/Gatekeeper)]

### SIP-RSVP Interleaving (The Coordination Problem)
Resource reservation must be coordinated with call signaling to prevent "ghost rings" (ringing before resources are guaranteed).
1.  **SDP Exchange**: Negotiate codecs via SIP.
2.  **RSVP PATH/RESV**: Reserve bandwidth based on the negotiated codec.
3.  **SIP PRACK**: Provisional acknowledgment (ensures synchronization).
4.  **Ringing/OK**: Final call setup only *after* `RESV` success.

[Image: Coordination of SIP signalling and RSVP resource reservation showing interleaving]

## Transport Protocols
*   **RTP (Real-Time Transport Protocol)**: Provides sequence numbers (for loss detection) and timestamps (to remove jitter).
*   **RTCP (Real-Time Control Protocol)**: Provides QoS feedback (loss rate, delay) to the sender, allowing for **Adaptive Encoding** (e.g., lowering bitrate during congestion).
