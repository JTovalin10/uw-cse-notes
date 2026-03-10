# Electronic Mail: SMTP, IMAP, and MIME

**Email** is a decoupled, asynchronous communication system utilizing a **Store-and-Forward** architecture. It is one of the most foundational **[[Traditional Applications]]** of the Internet.

---

## Message Format (RFC 822 & MIME)

### [[RFC 822]]: Standard Text Format
*   **Structure**: Composed of a **Header** section and a **Body**, separated by a single blank line (`<CRLF><CRLF>`).
*   **Headers**: Key-value pairs like `To:`, `From:`, `Subject:`, and `Received:`.

### [[MIME]]: Multipurpose Internet Mail Extensions
*   **Purpose**: Allows non-ASCII data (images, binary attachments) to be sent via legacy mail systems.
*   **[[Base64]] Encoding**: Maps 3 binary bytes into 4 ASCII characters to ensure data survival through ASCII-only relays.
*   **Content-Type**: Specifies the media type (e.g., `multipart/mixed`, `text/html`).

---

## Message Transfer (SMTP)

### [[SMTP]]: Simple Mail Transfer Protocol
*   **Role**: A "push" protocol used for transferring messages between **[[MTA]]**s (Message Transfer Agents).
*   **Transport**: Operates over **TCP Port 25** (Relay) or **587** (Submission).
*   **Store-and-Forward**: Intermediate **[[Mail Gateway]]**s buffer messages to disk before relaying them to the next hop.

[Image: Sequence of mail gateways store and forward email messages]

---

## Mail Access Protocols

Used by clients to *pull* messages from their home server.

### [[IMAP]]: Internet Message Access Protocol
*   **Characteristics**: **Stateful**. Synchronizes mailbox state (flags like `Seen`, `Deleted`) between client and server.
*   **Port**: **143** (Insecure) / **993** (SSL/TLS).

### [[POP]]: Post Office Protocol
*   **Characteristics**: Simpler, legacy alternative. Typically downloads and deletes mail from the server.
*   **Port**: **110** (Insecure) / **995** (SSL/TLS).

[Image: IMAP state transition diagram]
