# Page Load Time (PLT): Technical Analysis of Web Performance

## Low-Level Primer: Defining PLT
**Page Load Time (PLT)** is the critical metric representing the temporal interval between a user's initial interaction and the moment the browser completes the rendering of the requested content.

At the technical level, PLT is a composite metric influenced by the cumulative latencies of the entire network stack.

---

## Technical Components of PLT
The total load time is the sum of several discrete phases.

### 1. DNS Resolution
*   **Latency**: 1 **[[Round Trip Time (RTT)]]** to the recursive resolver (if not cached).

### 2. Connection Establishment (TCP Handshake)
*   **Mechanism**: The **Three-Way Handshake** (SYN $\to$ SYN-ACK $\to$ ACK).
*   **Latency**: 1 **RTT**.

### 3. Security Negotiation (TLS Handshake)
*   **Mechanism**: **Transport Layer Security (TLS)** handshake.
*   **Latency**: 1 **RTT** in **TLS 1.3**.

### 4. HTTP Request and Response
*   **Latency**: 1 **RTT** for the request/first byte, plus transfer time.

### 5. Resource Discovery and Fetching
*   **Dependency Graph**: Browser parses HTML and discovers nested resources.

*Figure: Sequence diagram showing DNS, TCP, TLS, and HTTP phases contributing to total PLT*

---

## Factors Influencing PLT
PLT is governed by the interaction between protocol mechanics and network constraints:

| Factor | Impact on PLT | Technical Reason |
| :--- | :--- | :--- |
| **Network RTT** | High | Protocols require multiple round trips before data flows. |
| **[[Bandwidth]]** | Variable | Critical for large objects; less impactful for small requests. |
| **Page Structure** | High | High number of small objects increases RTT overhead. |

---

## Optimization Strategies

### Persistent Connections (HTTP/1.1)
*   **Solution**: Keep the connection open to skip subsequent handshakes.

### Pipelining (HTTP/1.1)
*   **Failure Mode**: **[[Head-of-Line (HOL) Blocking]]**.

### HTTP/2 Multiplexing
*   **Mechanism**: Frames and interleaves requests over a single TCP connection.
*   **Benefit**: Eliminates HTTP-layer HOL blocking.

### HTTP/3 and QUIC
*   **Solution**: Uses **[[QUIC]]** over **UDP**. Handles stream multiplexing natively, solving transport-layer HOL blocking.

### Content Delivery Networks (CDN)
*   **Benefit**: Drastically reduces **RTT** by shortening physical distance.

*Figure: Comparison of HTTP/1.1 Sequential, HTTP/1.1 Pipelined, and HTTP/2 Multiplexed request patterns*
