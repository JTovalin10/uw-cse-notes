# Ports

**Ports** are 16-bit unsigned integers used by the transport layer to facilitate **Process-to-Process Demultiplexing**. They serve as logical "mailboxes" or communication endpoints, allowing a single [[IP Address]] to support multiple concurrent network applications by mapping incoming segments to specific process queues.

## Port Mechanics & Demultiplexing

*   **The Demultiplexing Key**: A transport-layer implementation identifies a unique communication channel using a **5-tuple**:
    *   **Source IP Address**
    *   **Source Port**
    *   **Destination IP Address**
    *   **Destination Port**
    *   **Protocol** (e.g., [[Transmission Control Protocol (TCP)]] or [[User Datagram Protocol (UDP)]])
*   **Abstraction Layer**: Ports decouple network communication from operating system internals; applications bind to **Ports** rather than process IDs (PIDs), which are transient and non-standardized across OS platforms.
*   **Implementation**: A port is typically implemented as a **Message Queue**. When a segment arrives, the transport protocol appends it to the queue associated with the destination port. If the queue is full, the segment is discarded (silently in UDP, or triggering flow control in TCP).

## Port Classification & Ranges

The 16-bit port space ($0$ to $65535$) is partitioned into three distinct ranges defined by IANA:

*   **Well-Known Ports (0–1023)**:
    *   Reserved for core system services and standardized protocols.
    *   Binding typically requires administrative/root privileges.
    *   **Examples**: [[HTTP]] (80), [[HTTPS]] (443), [[DNS]] (53), [[SSH]] (22), [[SMTP]] (25).
*   **Registered Ports (1024–49151)**:
    *   Used by specific user processes or applications (e.g., databases, game servers).
    *   Can be registered with IANA to avoid conflicts but do not require root privileges to bind.
*   **Dynamic/Ephemeral Ports (49152–65535)**:
    *   Temporary ports assigned by the OS to client applications for the duration of a session.
    *   Assigned automatically when a client initiates a connection.

## Service Discovery

*   **Direct Binding**: Clients connect to a server's **Well-Known Port**.
*   **Port Mapper (RPC Binder)**: In complex systems (like [[Remote Procedure Call (RPC)]]), a service may bind to a dynamic port. The client first queries a **Port Mapper** on a well-known port to retrieve the current port number for the requested service.

[Image: UDP message queue showing arrivals appended and discards on overflow]
