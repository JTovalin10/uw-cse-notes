# The World Wide Web: Architecture, Identifiers, and Caching

## Low-Level Primer: The Web as a Distributed System
The **World Wide Web (WWW)** is a global, distributed information space where **Resources** are identified by persistent strings and accessed via the **[[HTTP - Protocol Mechanics and Evolution|HTTP]]** protocol. While HTTP manages the "how" of data transfer, the Web architecture defines the "what" (Identifiers) and the "where" (Caching and Proxies).

---

## Resource Identifiers: URI, URL, and URN

### The Identifier Hierarchy
*   **URI (Uniform Resource Identifier)**: The master set of all identifiers.
*   **URN (Uniform Resource Name)**: A persistent, location-independent name (e.g., `urn:isbn:0451450523`).
*   **URL (Uniform Resource Locator)**: The most common URI, specifying a resource by its network location and the mechanism to retrieve it.

### Anatomy of a URL
A standard URL is composed of five distinct components:
`scheme://authority/path?query#fragment`

1.  **Scheme**: The protocol (e.g., `http`, `https`, `ftp`).
2.  **Authority**: Typically the **[[Domain Name System (DNS)|Host Name]]** and optional Port (e.g., `example.com:443`).
3.  **Path**: The hierarchical location of the resource on the server.
4.  **Query**: A string of non-hierarchical data (e.g., `?search=networking&sort=desc`).
5.  **Fragment**: A pointer to a specific anchor within the resource (e.g., `#section2`). *Note: Fragments are never sent to the server; they are handled entirely by the client.*

---

## State Management: Cookies and Sessions

HTTP is a **Stateless** protocol—the server does not remember the client between requests. To build applications (e.g., shopping carts), the Web uses **Cookies**.

### The Cookie Lifecycle
1.  **Set-Cookie**: The server sends a `Set-Cookie` header in the response (e.g., `Set-Cookie: session_id=12345; HttpOnly; Secure`).
2.  **Storage**: The browser stores this string associated with the domain.
3.  **Cookie Header**: For every subsequent request to that domain, the browser automatically includes the `Cookie: session_id=12345` header.

### Security Attributes
*   **HttpOnly**: Prevents JavaScript from accessing the cookie (mitigates **Cross-Site Scripting (XSS)**).
*   **Secure**: Ensures the cookie is only sent over HTTPS.
*   **SameSite**: Restricts whether cookies are sent with cross-site requests (mitigates **Cross-Site Request Forgery (CSRF)**).

---

## Advanced Web Caching

Caching is the primary mechanism for scaling the Web. It occurs at the browser, in the network (**Proxy**), and at the origin (**[[CDN]]**).

### Cache-Control Directives
*   **`public`**: Can be cached by any intermediate proxy.
*   **`private`**: Only the end-user's browser can cache it.
*   **`no-store`**: The resource must never be cached (used for sensitive data).
*   **`no-cache`**: The resource can be cached, but must be **revalidated** with the server before every use.
*   **`must-revalidate`**: If the resource becomes stale, it cannot be used without server confirmation.

### The `Vary` Header
Tells the cache which request headers (e.g., `Accept-Encoding`, `User-Agent`) were used to select the representation. This prevents a mobile user from receiving a cached desktop version of a page.

---

## Proxy Architectures

A **Proxy** is an intermediate entity that acts as both a client and a server.

### 1. Forward Proxy
*   **Role**: Sits in front of the **Client**.
*   **Goal**: Anonymity, content filtering, or institutional caching (e.g., a corporate firewall).

### 2. Reverse Proxy
*   **Role**: Sits in front of the **Server**.
*   **Goal**: **Load Balancing**, SSL termination, and caching. Users think they are talking to the origin server, but they are actually talking to the proxy.

### 3. Transparent Proxy
*   **Role**: Intercepts traffic at the network level without the client's knowledge or configuration.

---

## Content Negotiation

The process of the client and server agreeing on the best format for a resource.
*   **`Accept`**: Media types (e.g., `text/html`, `application/json`).
*   **`Accept-Encoding`**: Compression algorithms (e.g., `gzip`, `br` for Brotli).
*   **`Accept-Language`**: Preferred human language (e.g., `en-US`, `fr`).

[Image: Architecture diagram showing Client, Forward Proxy, the Internet, Reverse Proxy, and Origin Server]
