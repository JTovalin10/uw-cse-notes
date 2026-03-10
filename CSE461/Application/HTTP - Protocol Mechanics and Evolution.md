# HTTP: Protocol Mechanics, Performance, and Evolution

## High-Level Primer: The Request/Reply Architecture
The **HyperText Transfer Protocol (HTTP)** is the foundational **[[Application Layer]]** protocol of the World Wide Web. At a high level, it is a stateless protocol where a client (User Agent) and a server exchange "Resources" (HTML, JSON, Images) over a reliable transport network.

## Low-Level Primer: The Wire Format
Historically, HTTP was a human-readable **ASCII-based** protocol. As the Web evolved from simple text documents to complex, resource-heavy web applications, the protocol had to evolve into a highly optimized, **Binary-framed** system designed to minimize **[[Round-Trip Time (RTT)]]** and maximize link utilization.

Historically, HTTP has struggled with the "Wait" problem—latency introduced by both the underlying transport protocol and the application's own architectural constraints.

---

## HTTP/1.0: The Connection Overhead Problem

### High-Level Mechanism: One Object Per Connection
In HTTP/1.0, the protocol was incredibly simple: a client opens a connection, asks for one file, receives it, and the connection closes immediately. If a page has 10 images, the browser must open 10 separate connections.

### Low-Level Mechanism: The ASCII Wire Format
An HTTP/1.0 request and response are purely text-based, separated by a carriage-return and line-feed (`\r\n` or `<CRLF>`).

**The Request:**
```http
GET /index.html HTTP/1.0
Host: www.example.com
User-Agent: Mozilla/5.0
Accept: text/html
<CRLF>
```

**The Response:**
```http
HTTP/1.0 200 OK
Content-Type: text/html
Content-Length: 137
<CRLF>
<html>
  <body>Hello World</body>
</html>
```

### The Problem: [[Connection Latency and Slow Start]]
*   **[[TCP Three-Way Handshake|TCP Handshake]] Overhead**: Every new connection requires a full **[[Round-Trip Time (RTT)]]** to perform the `SYN` $\to$ `SYN-ACK` $\to$ `ACK` handshake before any HTTP data can be sent.
*   **[[Slow Start (TCP Additive Increase)|TCP Slow Start]] Penalty**: TCP starts with a small **[[Congestion Window (cwnd)]]** and grows it exponentially. Because most web objects are small, the connection often closes before the window is large enough to utilize the full available **[[Bandwidth]]**.
*   **Result**: The network spends more time "negotiating" the connection than actually moving data.

---

## HTTP/1.1: Persistence and the HOL Blocking Problem

### High-Level Mechanism: Keep-Alive and Pipelining
To solve the overhead of HTTP/1.0, HTTP/1.1 introduced **Persistent Connections**. A single TCP connection is kept open (`Connection: keep-alive`) and reused for multiple objects. It also introduced **Pipelining**, allowing the browser to ask for `image1.png`, `image2.png`, and `image3.png` all at once without waiting for the first one to finish downloading.

### Low-Level Mechanism: Chunked Transfer Encoding
Because the connection doesn't close after a response, the client needs a way to know when a response ends. If the server doesn't know the full `Content-Length` upfront (e.g., dynamically generated content), it uses `Transfer-Encoding: chunked`.

**The Pipelined Request:**
```http
GET /image1.png HTTP/1.1
Host: www.example.com
Connection: keep-alive
<CRLF>
GET /image2.png HTTP/1.1
Host: www.example.com
Connection: keep-alive
<CRLF>
```

### The Problem: [[Head-of-Line (HOL) Blocking|Application-Layer Head-of-Line (HOL) Blocking]]
*   **The Constraint**: HTTP/1.1 requires that the server return responses over the TCP socket in the **exact same order** they were requested (FIFO).
*   **The Failure**: If the server receives requests for A, B, and C, but request A requires a massive, slow database query, the server **cannot** send the responses for B or C over the socket—even if B and C are already generated and sitting in RAM. Requests B and C are "blocked" at the head of the line by request A.

[Image: Diagram showing HTTP/1.1 Pipelining sequential response requirement]

---

## HTTP/2: Binary Framing and the Transport HOL Problem

### High-Level Mechanism: Multiplexing
HTTP/2 abandons human-readable ASCII in favor of machine-optimized binary. It introduces **Multiplexing**: a single user's browser can interleave pieces of multiple concurrent requests and responses over a single TCP connection. The server can return data for image C before image A is finished.
*   **Benefit**: This effectively solves **Application-Layer HOL Blocking**.

### Low-Level Mechanism: The Binary Framing Layer
HTTP/2 chops messages into **[[Atomic]] Frames** and tags them with a **Stream ID**.
*   **Stream**: A logical bidirectional flow of frames (e.g., Stream `1` is the HTML file, Stream `3` is the CSS file).
*   **Frames**: The basic protocol unit (e.g., `HEADERS`, `DATA`, `SETTINGS`, `PRIORITY`).
*   **Atomic Frames (Definition)**: In this context, **[[Atomic]]** means "indivisible." Once a frame (typically 16KB) starts being sent on the wire, it cannot be interrupted. However, once that frame finishes, the next frame can belong to a completely different Stream ID. This allows a massive 10MB image (Stream 1) to be "broken up" so that a small 1KB script (Stream 3) doesn't have to wait for the entire image to finish; it just waits for the current *frame* of the image to finish.
*   **HPACK**: Because headers (like cookies and user agents) are highly repetitive, HTTP/2 uses **HPACK** compression to drastically shrink header sizes using static and dynamic dictionaries.

**The Wire Format (Conceptual Binary Representation):**
```text
+-----------------------------------------------+
|                 Length (24)                   |
+---------------+---------------+---------------+
|   Type (8)    |   Flags (8)   |
+-+-------------+---------------+-------------------+
|R|                 Stream Identifier (31)          |
+=+=================================================+
|                   Frame Payload (0...)          ...
+---------------------------------------------------+

Example Interleaved Flow on the wire:
[HEADERS Frame | Stream 1 | GET /index.html]
[HEADERS Frame | Stream 3 | GET /style.css]
[DATA Frame    | Stream 3 | body { color: red; } ]   <-- CSS returns first!
[DATA Frame    | Stream 1 | <html>... ]
```

### The Problem: [[Head-of-Line (HOL) Blocking|Transport-Layer Head-of-Line (HOL) Blocking]]
*   **The Constraint**: HTTP/2 still runs on top of **[[Transmission Control Protocol (TCP)|TCP]]**, which views all data as a single, contiguous **Byte Stream**.
*   **The Failure**: TCP has no concept of HTTP/2's internal "Streams." If a single TCP packet is lost in the network, the TCP stack at the receiver **stops all processing** and waits for the retransmission of that specific packet.
*   **Result**: A lost TCP packet carrying a piece of Stream 1 (HTML) will completely stall the delivery of Stream 3 (CSS) to the browser, even though the CSS data has already physically arrived at the NIC.

---

## HTTP/3: QUIC and the Ultimate Fix

### High-Level Mechanism: Ditching TCP
HTTP/3 replaces TCP entirely with **[[QUIC]]**, a new transport protocol built on top of **[[User Datagram Protocol (UDP)|UDP]]**. It moves the reliability, congestion control, and cryptography (TLS 1.3) into a single, cohesive layer.

### Low-Level Mechanism: Independent Streams over UDP
Because QUIC is built specifically for HTTP multiplexing, it handles reliability and sequencing at the **stream level** rather than the connection level. 

**The Wire Format (Conceptual QUIC Packet):**
```text
[ UDP Header | Src Port, Dst Port, Length, Checksum ]
[ QUIC Header | Connection ID, Packet Number ]
[ QUIC Frame | Stream ID: 3, Offset: 0, Data: "body { color: red; }" ]
[ QUIC Frame | Stream ID: 1, Offset: 500, Data: "</html>" ]
```
*   **Solution**: If a UDP packet containing data for Stream 1 is lost, QUIC only stalls Stream 1. The data for Stream 3 is instantly passed up to the browser. This perfectly eliminates **Transport-Layer HOL Blocking**.

### The Bonus Mechanism: 0-RTT Handshake
*   **The Problem: Multi-Flight Latency**: Standard HTTPS over TCP requires a TCP handshake (1 RTT) followed by a TLS handshake (1-2 RTTs) before the HTTP `GET` can be sent.
*   **The Fix**: QUIC combines the transport and cryptographic handshakes. For returning users (where the client has a previous session ticket), the client can encrypt the HTTP `GET` request and include it in the very first UDP packet (**0-RTT**), drastically reducing **[[Page Load Time (PLT)]]**.

---

## Summary of Protocol Evolutions

| Feature | HTTP/1.1 | HTTP/2 | HTTP/3 |
| :--- | :--- | :--- | :--- |
| **Transport Layer** | TCP | TCP | **QUIC (UDP)** |
| **Framing** | ASCII Text | **Binary Frames** | **Binary Frames** |
| **Multiplexing** | No (Pipelined only) | Yes (Application Level) | **Yes (Transport Level)** |
| **Header Compression** | None | HPACK | QPACK |
| **Primary Problem Solved**| Connection Overhead | **[[Head-of-Line (HOL) Blocking\|Application HOL]]** | **[[Head-of-Line (HOL) Blocking\|Transport HOL]]** |
| **Handshake Latency** | 1 RTT (+ TLS) | 1 RTT (+ TLS) | **0-1 RTT (Combined TLS)** |

---

## Caching Mechanics: Validators and Freshness

To prevent making requests entirely, HTTP utilizes aggressive caching at the browser and CDN levels.

### 1. Freshness (Expiration)
*   **`Cache-Control: max-age=3600`**: Defines the "freshness lifetime" of a resource in seconds. The browser will not contact the server again for this file until the time expires.

### 2. Validation (The "Stale" Problem)
*   **The Problem**: A cache may have a copy of a resource whose `max-age` has expired, but the browser doesn't know if the file on the server has *actually* been changed. Re-downloading a file that hasn't changed wastes bandwidth.
*   **The Fix (Conditional GET)**: The client sends a request with an **[[ETag]]** (a cryptographic hash of the file provided by the server previously) via the `If-None-Match` header.
    ```http
    GET /style.css HTTP/1.1
    If-None-Match: "33a64df551425fcc55e4d42a148795d9f25f89d4"
    ```
*   **Result**: If the server calculates the hash of the current file and it matches the client's ETag, the server replies with a tiny **`304 Not Modified`** response containing no body, instantly validating the client's stale cache.

[Image: Sequence diagram comparing HTTP/2 HOL blocking vs. HTTP/3 independent streams]
