# Traditional Applications

**Traditional Applications** operate primarily on the **Client/Server** and **Request/Reply** paradigms. They are fundamentally composed of two parts: the **Application Program** (the user-facing software, like a browser or mail client) and the **Application Protocol** (the standardized rules dictating how machines exchange data over the network, e.g., [[HTTP]], [[SMTP]]). 

## Low-Level Primer: Formats and Transports
*   **Application Protocol vs. Data Format**: The transport protocol (e.g., SMTP) manages *how* bytes are moved; a companion standard (e.g., [[MIME]], [[HTML]]) defines *what* those bytes mean.
*   **ASCII vs Binary**: Legacy protocols (SMTP, HTTP/1.1) use human-readable **ASCII** text encoding delimited by `<CRLF>` (Carriage Return Line Feed). Modern protocols (HTTP/2, HTTP/3, [[gRPC]]) use **Binary Framing** for computational efficiency.
*   **Stateless vs. Stateful**: A stateless protocol (HTTP) treats every request as independent; a stateful protocol ([[IMAP]]) remembers client context across multiple transactions.

---

## Electronic Mail

Email is a decoupled, asynchronous communication system utilizing a **Store-and-Forward** architecture.

### Message Format (RFC 822 & MIME)
*   **[[RFC 822]]**: The baseline standard for text-based messages.
    *   **Structure**: A **Header** section and a **Body**, separated by a single blank line (`<CRLF><CRLF>`).
    *   **Headers**: Formatted as `<type>: <value><CRLF>`. Common headers include `To:`, `From:`, `Subject:`, `Date:`, and `Received:` (used to track routing history).
*   **[[MIME]] (Multipurpose Internet Mail Extensions)**: An extension to RFC 822 allowing the transmission of non-ASCII data (images, audio, attachments).
    *   **Key Headers**: `MIME-Version`, `Content-Type` (e.g., `image/jpeg`, `multipart/mixed`), `Content-Transfer-Encoding`.
    *   **[[Base64]] Encoding**: A critical mechanism that maps 3 binary bytes into 4 ASCII characters (using a 64-character alphabet: `A-Z`, `a-z`, `0-9`, `+`, `/`). This allows arbitrary binary data to survive legacy ASCII-only mail relays.

### Message Transfer (SMTP)
*   **[[MTA]] (Message Transfer Agent)**: A background daemon (e.g., Postfix, Sendmail) responsible for routing and delivering mail.
*   **[[Mail Gateway]]**: An intermediate MTA that temporarily buffers messages to disk (**store-and-forward**) before relaying them to the next hop.
*   **[[SMTP]] (Simple Mail Transfer Protocol)**: The push protocol operating over **TCP Port 25** (or **587** for secure submission).
    *   **Dialog**: A stateful, ASCII-based client/server conversation.
    *   **Commands**: `HELO`/`EHLO` (identify), `MAIL FROM` (envelope sender), `RCPT TO` (envelope recipient), `DATA` (begin payload), `QUIT`.
    *   **Status Codes**: `250` (OK), `354` (Start input), `550` (No such user).

[Image: Sequence of mail gateways store and forward email messages]

### Mail Access Protocols
Used by the client to *pull* messages from their designated MTA.
*   **[[IMAP]] (Internet Message Access Protocol)**: Operates over **TCP Port 143** (or **993** for IMAPS).
    *   **Stateful**: Synchronizes mailbox state (flags like `Seen`, `Deleted`, `Answered`) between the client and server. Allows keeping primary storage on the server.
    *   **Commands**: `LOGIN`, `FETCH`, `STORE`, `EXPUNGE`.
*   **[[POP]] (Post Office Protocol)**: Operates over **TCP Port 110** (or **995** for POP3S). A simpler, older alternative designed to download mail to local storage and optionally delete it from the server.

[Image: IMAP state transition diagram]

---

## The World Wide Web

The Web is a massive, distributed system of interlinked documents.

### Identifiers
*   **[[URI]] (Uniform Resource Identifier)**: The master classification for identifying a resource globally.
    *   **[[URL]] (Uniform Resource Locator)**: Specifies *how* to access a resource based on its location (e.g., `http://...`).
    *   **[[URN]] (Uniform Resource Name)**: Names a resource persistently regardless of its current location.

### [[HTTP]] (HyperText Transfer Protocol)
A stateless request/response protocol operating by default over **TCP Port 80** (or **443** for HTTPS).
*   **Message Format**: 
    1. `START_LINE` (Request Line or Status Line)
    2. `MESSAGE_HEADER`s
    3. `<CRLF>` (Blank line)
    4. `MESSAGE_BODY` (Payload)
*   **Request Methods**:
    *   **GET**: Retrieve a document.
    *   **HEAD**: Retrieve only headers (metadata) to check validity/modification time without downloading the body.
    *   **POST**: Submit a payload (e.g., form data) to the server.
    *   **PUT**: Upload/Replace a document at a specific URI.
    *   **DELETE**: Remove the specified URI.
*   **Response Codes**:
    *   **1xx (Informational)**: Request received, continuing.
    *   **2xx (Success)**: `200 OK`, `201 Created`.
    *   **3xx (Redirection)**: `301 Moved Permanently`, `304 Not Modified` (Cache validation).
    *   **4xx (Client Error)**: `400 Bad Request`, `403 Forbidden`, `404 Not Found`.
    *   **5xx (Server Error)**: `500 Internal Server Error`, `502 Bad Gateway`.

### The Evolution of HTTP
*   **[[HTTP/1.0]]**: High overhead; requires a new, separate [[TCP]] connection for every single inline object (images, scripts).
    [Image: HTTP 1.0 behavior]
*   **[[HTTP/1.1]]**: Introduces **Persistent Connections** (`Connection: keep-alive`) and Pipelining. Multiple requests can reuse the same TCP session, heavily reducing latency and maximizing the TCP congestion window.
    [Image: HTTP 1.1 behavior with persistent connections]
*   **[[HTTP/2]]**: Shifts from ASCII to **Binary Framing**. Introduces **Multiplexing** (multiple concurrent streams over one TCP connection to fix HTTP/1.1 Head-of-Line blocking), **Server Push**, and **HPACK Header Compression**.
*   **[[HTTP/3]]**: Abandons TCP entirely. Uses **[[QUIC]]** (built over [[User Datagram Protocol (UDP)]]).
    *   **Solves TCP Head-of-Line Blocking**: Packet loss on one stream does not block other multiplexed streams.
    *   **0-RTT Handshake**: Merges transport connection and TLS cryptographic handshakes into a single flight.

### Caching
A critical mechanism to reduce bandwidth, load, and latency.
*   **Locations**: Client browser cache, Institutional [[Proxy]] servers, ISP caches.
*   **Validation Mechanics**:
    *   **Absolute Expiration**: The `Expires:` header defines a hard date/time when a cached object becomes stale.
    *   **Conditional GET**: The client uses the `If-Modified-Since:` header. If the object hasn't changed, the server replies with `304 Not Modified` and an empty body, instructing the client to use the cache.

---

## Web Services & Cloud

Machine-to-machine application paradigms.

### Service Architectures
*   **[[SOAP]] (Simple Object Access Protocol)**: An **Operation-Oriented** (RPC-like) protocol.
    *   **[[WSDL]] (Web Services Description Language)**: An XML-based schema defining available operations, message formats, and network bindings.
    *   **Extensible**: Heavily modularized with WS-* standards (WS-Security, WS-ReliableMessaging).
    [Image: SOAP message structure]
*   **[[REST]] (Representational State Transfer)**: A **Data-Oriented**, stateless architecture.
    *   Exposes entities as URIs and manipulates them strictly using standard [[HTTP]] methods (GET, POST, PUT, DELETE).
    *   Payload representations are typically passed via **[[JSON]]** or **[[XML]]**.
*   **Cloud Native**: Modern infrastructure relying heavily on **[[Micro-services]]** communicating via high-performance binary RPCs (e.g., **[[gRPC]]** utilizing **[[Protobufs]]** for serialization) to achieve web-scale performance.