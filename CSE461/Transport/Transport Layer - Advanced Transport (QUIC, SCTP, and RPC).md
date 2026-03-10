# Transport Layer: Advanced Transport (QUIC, SCTP, and RPC)

## Low-Level Primer: Beyond the TCP/UDP Dichotomy
While TCP and UDP are the workhorses of the Internet, many modern applications require features that neither protocol provides natively—such as multi-streaming to avoid Head-of-Line blocking, or integrated encryption for faster connection setup.

---

## 1. QUIC (Quick UDP Internet Connections)

QUIC is the foundation for **HTTP/3** and is designed to replace the TCP+TLS stack.

### Key Mechanics
*   **UDP Substrate**: Runs over UDP to ensure easy deployment through firewalls and NATs.
*   **0-RTT Handshake**: Combines transport and cryptographic handshakes. Returning users can send data in the very first packet.
*   **Multi-streaming**: Supports multiple independent data streams within a single connection. If a packet for one stream is lost, only that stream stalls (eliminates **[[Head-of-Line (HOL) Blocking|Transport-Layer HOL Blocking]]**).
*   **Connection Migration**: Uses a **Connection ID** rather than an IP/Port tuple, allowing a session to survive a switch from Wi-Fi to cellular.

---

## 2. SCTP (Stream Control Transmission Protocol)

A message-oriented reliable transport protocol originally designed for telephony signaling.

### Key Features
*   **Multi-Homing**: A single connection can span multiple IP addresses at both endpoints for seamless failover.
*   **Multi-streaming**: Like QUIC, it allows independent streams to prevent HOL blocking.
*   **Preserved Boundaries**: Unlike TCP's byte-stream, SCTP preserves the size of the original `send()` calls.

---

## 3. Remote Procedure Call (RPC)

RPC is a programming abstraction that allows a program to execute a procedure on a remote server as if it were a local function call.

### The RPC Workflow
1.  **Client Stub**: Marshals arguments into a message and sends it to the server.
2.  **Server Stub**: Unmarshals arguments, calls the actual function, and marshals the result.
3.  **Transport**: Can use TCP, UDP, or specialized protocols like **[[gRPC]]** (which uses HTTP/2).

### Challenges
*   **Failure Semantics**: What if the server crashes after the call? 
    *   **At-Least-Once**: Retransmit until an ACK is received.
    *   **At-Most-Once**: Use transaction IDs to ensure the function is only executed once even if retransmitted.
*   **Performance**: RPC is often used for small, frequent calls, making the RTT overhead of handshakes very costly.

---

## 4. Advanced Congestion Control (Non-Loss Based)

Traditional TCP (Reno) reacts to packet loss, which is a late and noisy signal.
*   **Delay-Based (TCP Vegas)**: Monitors increases in RTT as a signal that buffers are filling up.
*   **Model-Based (TCP BBR)**: Estimates the **Bottleneck Bandwidth** and **Min RTT** to maintain a transmission rate that matches the physical capacity without filling buffers.

[Image: Comparison graph showing buffer occupancy for Loss-based vs. Delay-based congestion control]
