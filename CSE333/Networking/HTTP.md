# CSE 333: HTTP

The **Hypertext Transfer Protocol (HTTP)** is an application-level request/response protocol that dictates how web browsers and web servers communicate. It is implemented on top of TCP streams.

## HTTP Basics
1.  A client establishes one or more TCP connections to a server.
2.  The client sends a **request** for a resource (identified by a **URI**).
3.  The server sends a **reponse** containing the resource or an error message.

## HTTP Requests
General form:
```http
[METHOD] [request-uri] HTTP/[version]
[headerfield1]: [fieldvalue1]
[headerfield2]: [fieldvalue2]
...
[headerfieldN]: [fieldvalueN]
(blank line)
[request body, if any]
```

### Common Methods
*   **GET**: Request a named resource.
*   **POST**: Submit data to the server (e.g., file upload).
*   **HEAD**: Request only the headers for a resource (useful for checking if a cached copy is still valid).

### Client Headers
*   **Host**: The DNS name of the server.
*   **User-Agent**: Identifying string for the browser.
*   **Accept**: Content types the client prefers.
*   **Cookie**: HTTP cookie previously set by the server.

## HTTP Responses
General form:
```http
HTTP/[version] [status code] [reason]
[headerfield1]: [fieldvalue1]
...
(blank line)
[reponse body, if any]
```

### Status Codes
*   **1xx**: Informational message.
*   **2xx**: Success (e.g., `200 OK`).
*   **3xx**: Redirect (e.g., `301 Moved Permanently`).
*   **4xx**: Client error (e.g., `404 Not Found`).
*   **5xx**: Server error (e.g., `500 Server Error`).

### Server Headers
*   **Server**: String identifying the server software.
*   **Content-Type**: MIME type of the requested object (e.g., `text/html`).
*   **Content-Length**: Size of the requested object in bytes.
*   **Last-Modified**: Date/time the object was last changed.

## HTTP/1.1 Features
*   **Chunked Transfer-Encoding**: Allows the server to start sending a response before it knows the total size.
*   **Persistent Connections**: Multiple requests can be sent over a single TCP connection, reducing the overhead of repeated TCP handshakes.

## HTTP/2
Standardized in 2015, HTTP/2 is a **binary protocol** (easier for machines to parse) that allows multiple data streams to be multiplexed on a single TCP connection. It also includes header compression and server push.

# Related
- [[CSE461/Application/HTTP - Protocol Mechanics and Evolution|CSE461: HTTP]]
