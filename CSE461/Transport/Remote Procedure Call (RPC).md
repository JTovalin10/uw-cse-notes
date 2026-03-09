# Remote Procedure Call (RPC)

**Remote Procedure Call (RPC)** is a transport-layer paradigm that provides a **Procedural Abstraction** over network communication. It allows a process to invoke a function on a remote system as if it were a local call, hiding the complexities of message passing, data serialization, and network reliability.

## Low-Level Primer: The RPC Model
*   **Request/Reply Paradigm**: RPC is fundamentally synchronous (though asynchronous versions exist). The client sends a request and **blocks** until the server returns a result.
*   **Components of the RPC Stack**:
    *   **Client Stub**: A local proxy for the remote function. It handles the **Marshalling** of arguments.
    *   **Marshalling (Serialization)**: The process of packaging function arguments into a standardized, machine-independent binary format.
    *   **Unmarshalling (Deserialization)**: Reconstructing the native data structures from the received binary stream.
    *   **Transport Protocol**: The underlying delivery mechanism (usually [[User Datagram Protocol (UDP)]] or [[Transmission Control Protocol (TCP)]]).

[Image: Complete RPC mechanism showing stubs, marshallers, and the network transport]

## Addressing & Service Discovery
*   **Program/Procedure Identifiers**: Procedures are typically identified by a tuple: `(Program Number, Version Number, Procedure Number)`.
*   **Port Mapper / RPCBIND**: Since servers often bind to dynamic [[Ports]], they register their current port with a **Port Mapper** (typically on **Well-Known Port 111**). Clients query the Port Mapper to "bind" to the correct port for a specific service.

## Reliability & Semantics
Because networks can lose or duplicate messages, RPC must define its failure semantics:

| Semantic | Logic | Requirement |
| :--- | :--- | :--- |
| **At-Least-Once** | Client keeps retrying until it gets a reply. | Procedure must be **Idempotent** (safe to repeat). |
| **At-Most-Once** | Server filters duplicates. If the reply is lost, the call fails or returns a cached result. | Requires server state to track **Transaction IDs (XIDs)**. |
| **Exactly-Once** | The ideal; virtually impossible in the face of machine crashes and network partitions. | Usually approximated by high-level transaction logs. |

### Message Matching
*   **XID (Transaction ID)**: A unique identifier generated for each call. The reply must carry the same XID as the request.
*   **Boot ID**: A value that changes every time a host reboots. Combined with the XID, it prevents a "delayed" request from a previous boot incarnation from being accepted as valid.

---

## RPC Implementations

### SunRPC (ONC RPC)
The foundation of **NFS** (Network File System).
*   **XDR (External Data Representation)**: The canonical data format. It uses big-endian byte order and 4-byte alignment.
*   **XID Persistence**: Standard SunRPC does not remember XIDs across reboots, potentially violating at-most-once semantics during crashes.

### DCE-RPC
A more complex implementation used in Microsoft's **DCOM** and **Active Directory**.
*   **Activity IDs**: Tracks a logical sequence of calls (a "channel") between a client and server.
*   **Implicit ACKs**: The next request in a sequence serves as an ACK for the previous reply.
*   **Fack (Fragment ACK)**: Selective acknowledgment for large RPC messages that have been fragmented across multiple UDP packets.

### gRPC (Modern Cloud RPC)
Developed by Google for high-performance **[[Micro-services]]**.
*   **Transport**: Runs exclusively over **HTTP/2** over **TLS**. 
*   **Serialization**: Uses **Protocol Buffers ([[Protobufs]])**, a highly efficient, typed binary format.
*   **Streaming**: Supports Unary (Request/Response), Server Streaming, Client Streaming, and Bidirectional Streaming.
*   **Interface Definition Language (IDL)**: Uses `.proto` files to define service interfaces, which are then compiled into stubs for multiple languages (C++, Go, Python, etc.).

[Image: gRPC stack showing HTTP/2 transport and Protocol Buffers]

## Overcoming Network Limitations
*   **Implicit Acknowledgment**: To reduce traffic, the server treats the next request from the same client as an ACK for the previous response.
*   **Periodic Pings**: If a server takes a long time to process a request, the client sends a "Ping" to verify the server is still alive; the server responds with a "Working" message.
