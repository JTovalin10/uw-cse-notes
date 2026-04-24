# CSE 333: DNS

The **Domain Name System (DNS)** is a distributed, hierarchical database that translates human-readable domain names (e.g., `www.google.com`) into machine-routable IP addresses.

## DNS Hierarchy
DNS is organized into a tree structure:
1.  **Root Name Servers**: Represented by a dot (`.`).
2.  **Top-Level Domains (TLD)**: `.com`, `.edu`, `.org`, `.cn`, etc.
3.  **Authoritative Name Servers**: Manage specific domains (e.g., `google.com`).
4.  **Subdomains**: `mail.google.com`, `docs.google.com`.

## IP Network Addresses
*   **IPv4**: A 4-byte (32-bit) tuple, usually written in "dotted-decimal" notation (e.g., `128.95.4.1`). The IPv4 address space is exhausted.
*   **IPv6**: A 16-byte (128-bit) tuple, written in "hextets" (groups of 4 hex digits) separated by colons (e.g., `2d01:db8:f188::1f33`). `::` can replace consecutive sections of zeros.

## Resolving DNS Names in C
The POSIX way to resolve names is using `getaddrinfo()`, found in `#include <netdb.h>`.

### getaddrinfo()
```c
int getaddrinfo(const char* hostname, 
               const char* service, 
               const struct addrinfo* hints, 
               struct addrinfo** res);
```
*   **hostname**: Domain name or IP address string.
*   **service**: Port number (e.g., `"80"`) or service name (e.g., `"www"`).
*   **hints**: A `struct addrinfo` that specifies constraints (e.g., `AF_INET6` for IPv6, `SOCK_STREAM` for TCP).
*   **res**: A pointer to a pointer that will hold the resulting linked list of `addrinfo` structures.

### addrinfo Structure
```c
struct addrinfo {
    int              ai_flags;     // AI_PASSIVE, AI_CANONNAME, etc.
    int              ai_family;    // AF_INET, AF_INET6, AF_UNSPEC
    int              ai_socktype;  // SOCK_STREAM, SOCK_DGRAM
    int              ai_protocol;  // IPPROTO_TCP, IPPROTO_UDP
    size_t           ai_addrlen;   // length of ai_addr
    struct sockaddr* ai_addr;      // binary address
    char*            ai_canonname; // canonical name
    struct addrinfo* ai_next;      // next item in linked list
};
```

You must use `freeaddrinfo()` to free the memory allocated by `getaddrinfo()`.

## Address Conversion
*   **inet_pton**: Converts human-readable strings ("presentation") to network byte ordered binary addresses.
*   **inet_ntop**: Converts binary addresses to human-readable strings.

# Related
- [[CSE461/Application/Domain Name System (DNS)|CSE461: DNS]]
