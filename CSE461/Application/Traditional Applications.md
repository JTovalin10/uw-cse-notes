# 9.1 Traditional Applications

## Overview
Focus on **Request/Reply** paradigm. Distinguished by **Application Programs** (client UI) vs. **Application Protocols** (standardized communication rules, e.g., [[HTTP]], [[SMTP]]).

### Key Components
- **Application Program**: User-facing software (e.g., Chrome, Outlook).
- **Application Protocol**: Standards for interoperation (e.g., [[HTTP]], [[SMTP]]).
- **Companion Protocols**: Protocols defining data format (e.g., [[HTML]] for [[HTTP]], [[MIME]] for [[SMTP]]).

---

## 9.1.1 Electronic Mail ([[SMTP]], [[MIME]], [[IMAP]])

### Message Format
*   **[[RFC 822]]**: Defines text-based messages with a **Header** and **Body**, separated by a blank line.
    *   **Headers**: `<type>: <value>` terminated by `<CRLF>`. Examples: `To:`, `From:`, `Subject:`, `Date:`, `Received:`.
*   **[[MIME]] (Multipurpose Internet Mail Extensions)**: Extends [[RFC 822]] for non-ASCII data.
    *   **Key Headers**: `MIME-Version`, `Content-Description`, `Content-Type` (e.g., `image/jpeg`, `text/richtext`), `Content-Transfer-Encoding`.
    *   **Multipart Type**: Allows multiple data types in one message (e.g., `multipart/mixed`).
    *   **[[Base64]] Encoding**: Maps 3 binary bytes to 4 ASCII characters (6 bits per character). Uses 64-character set: `A-Z`, `a-z`, `0-9`, `+`, `/`.

### Message Transfer
*   **[[MTA]] (Message Transfer Agent)**: A mail daemon (e.g., `sendmail`, `postfix`) that moves mail using [[SMTP]] over [[TCP]].
*   **[[Mail Gateway]]**: Intermediate MTA performing **store-and-forward** (buffers to disk).
*   **[[SMTP]] (Simple Mail Transfer Protocol)**: ASCII-based client/server dialog.
    *   **Commands**: `HELO`, `MAIL FROM`, `RCPT TO`, `DATA`, `QUIT`, `VRFY`.
    *   **Status Codes**: `250` (OK), `550` (No such user), `354` (Start input), `221` (Closing).
    *   **Envelope**: Arguments extracted from headers for routing.
* [Image: Sequence of mail gateways store and forward email messages]

### Mail Access Protocols
*   **[[IMAP]] (Internet Message Access Protocol)**: Client/server protocol for remote mailbox management.
    *   **Stateful**: Synchronizes flags (e.g., `Seen`, `Deleted`) between client and server.
    *   **Commands**: `LOGIN`, `FETCH`, `EXPUNGE`, `LOGOUT`.
*   **[[POP]] (Post Office Protocol)**: Simpler alternative, typically downloads/removes mail from server.
* [Image: IMAP state transition diagram]

---

## 9.1.2 World Wide Web ([[HTTP]])

### Identifiers
*   **[[URI]] (Uniform Resource Identifier)**: Global identifier for a resource.
    *   **[[URL]] (Uniform Resource Locator)**: Specifies location/access method (e.g., `http://...`).
    *   **[[URN]] (Uniform Resource Name)**: Names a resource regardless of location.

### [[HTTP]] (HyperText Transport Protocol)
*   **Structure**: Request/Response over [[TCP]] (traditionally port 80).
*   **Message Format**: `START_LINE`, `MESSAGE_HEADER`, `<CRLF>`, `MESSAGE_BODY`.
*   **Request Methods**:
    | Method | Description |
    | :--- | :--- |
    | **GET** | Retrieve document. |
    | **HEAD** | Retrieve metadata only (check validity/modification). |
    | **POST** | Submit data to server (forms, annotations). |
    | **PUT** | Upload document to URL. |
    | **DELETE** | Remove URL. |

### Response Codes
| Range | Type | Example |
| :--- | :--- | :--- |
| **1xx** | Informational | Request received. |
| **2xx** | Success | `200 OK`, `202 Accepted`. |
| **3xx** | Redirection | `301 Moved Permanently`, `302 Found`. |
| **4xx** | Client Error | `400 Bad Request`, `404 Not Found`. |
| **5xx** | Server Error | `500 Internal Server Error`. |

---

## Evolution of [[HTTP]]

### [[HTTP/1.0]]
- Separate [[TCP]] connection per data item. High overhead.
- [Image: HTTP 1.0 behavior]

### [[HTTP/1.1]]
- **Persistent Connections**: Multiple requests over one [[TCP]] session.
- Reduces latency and improves [[TCP]] congestion window efficiency.
- [Image: HTTP 1.1 behavior with persistent connections]

### [[HTTP/2]]
- **Binary Framing**: Replaces text-based format.
- **Multiplexing**: Multiple concurrent streams over one [[TCP]] connection.
- **Server Push**: Proactively send resources to client.
- **Header Compression**: Uses HPACK.

### [[HTTP/3]] & [[QUIC]]
- Uses **[[QUIC]]** (over [[UDP]]) instead of [[TCP]].
- **Eliminates Head-of-Line Blocking**: Packet loss only affects one stream.
- **0-RTT Handshake**: Combines connection and security establishment.

---

## [[Caching]]
- **Strategies**: Browser cache, [[Proxy]] (ISP cache).
- **Validation**:
    *   **`Expires` Header**: Absolute date/time for staleness.
    *   **Conditional GET**: `If-Modified-Since` header; server returns `304 Not Modified` if unchanged.

---

## 9.1.3 Web Services & Cloud

### Architectures
*   **[[SOAP]] (Simple Object Access Protocol)**: Procedural/Operation-oriented.
    *   **[[WSDL]]**: XML-based interface definition (operations, messages, bindings).
    *   **Features/Modules**: Composable protocol elements (reliability, security).
    * [Image: SOAP message structure]
*   **[[REST]] (Representational State Transfer)**: Data-oriented/Stateless.
    *   Uses standard [[HTTP]] methods.
    *   Resources identified by URIs; representation passed via **[[JSON]]** or **[[XML]]**.
*   **Cloud Native**: Uses **[[Micro-services]]** (e.g., [[gRPC]] + [[Protobufs]]) for scalability.
