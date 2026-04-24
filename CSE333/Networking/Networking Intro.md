# CSE 333: Networking Intro

Networking in CSE 333 focuses on the **Client-Server Model**, where a client application establishes a connection to a server to request resources or services.

## The OSI Model Layers
Modern networking is built on a series of abstraction layers:

1.  **Physical Layer**: Individual bits are modulated onto a physical medium (copper wire, optical cable, radio).
2.  **Data Link Layer**: Multiple computers on a **Local Area Network (LAN)** contend for the medium. Data is "packetized" into frames, and devices are addressed using **Media Access Control (MAC)** addresses.
3.  **Network Layer (IP)**: The **Internet Protocol (IP)** routes packets across multiple networks. Every computer has a unique IP address. Routers span networks to get packets closer to their destination.
4.  **Transport Layer (TCP/UDP)**:
    *   **Transmission Control Protocol (TCP)**: Provides reliable, ordered, congestion-controlled byte streams. It uses **ports** (up to 65,535) to identify specific applications on a host.
    *   **User Datagram Protocol (UDP)**: A thin layer providing unreliable packet delivery.
5.  **Application Layer**: Defines the format and meaning of messages between application entities (e.g., [[HTTP]], [[DNS]], SMTP, SSH).

## Packet Encapsulation
As data moves down the stack, each layer wraps the higher-layer's data with its own header:
*   **Application Data** is wrapped in a **TCP Header** (Transport).
*   The TCP segment is wrapped in an **IP Header** (Network).
*   The IP packet is wrapped in an **Ethernet Header/Trailer** (Data Link).

On the receiving end, each layer "unwraps" its respective header to pass the payload up to the next layer.

## Popular Application Protocols
*   [[DNS]]: Translates domain names (e.g., `google.com`) into IP addresses.
*   [[HTTP]]: Web protocols for requesting and receiving resources.
*   **SMTP/IMAP/POP**: Mail delivery and access protocols.
*   **SSH**: Secure remote login protocol.
*   **BitTorrent**: Peer-to-peer file sharing.

## Tools
*   **netcat (nc)**: A networking utility for reading from and writing to network connections using TCP or UDP.
    *   Listen: `nc -l <port>`
    *   Connect: `nc <IPaddr> <port>`
