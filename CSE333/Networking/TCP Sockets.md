# CSE 333: TCP Sockets

The **Berkeley Sockets** API is the standard API for network programming, originated in 4.2BSD Unix. UNIX treats network communications as file I/O, using **file descriptors** called **sockets**.

## Client TCP Connection Steps
Connecting to a server involves five main steps:

1.  **Find IP/Port**: Use [[DNS]] (specifically `getaddrinfo`) to find the address and port.
2.  **Create Socket**: Use the `socket()` system call.
3.  **Connect**: Use `connect()` to establish a connection to the remote server.
4.  **Communicate**: Use `read()` and `write()` (or `send()` and `recv()`) to exchange data.
5.  **Close**: Use `close()` to shut down the connection and free resources.

## Linux Socket API
### socket()
```c
int socket(int domain, int type, int protocol);
```
*   **domain**: `AF_INET` (IPv4) or `AF_INET6` (IPv6).
*   **type**: `SOCK_STREAM` (TCP) or `SOCK_DGRAM` (UDP).
*   **protocol**: Usually `0` (let the OS choose based on type).
Returns a file descriptor or `-1` on error.

### connect()
```c
int connect(int sockfd, const struct sockaddr* addr, socklen_t addrlen);
```
*   Established a connection to the remote host. This is a **blocking** call by default and involves ~2 round trips across the network.

## Network Byte Order
Computers may use different **endianness**. The network standard is **Big Endian**.
*   **Host to Network**: `htons()` (short), `htonl()` (long).
*   **Network to Host**: `ntohs()` (short), `ntohl()` (long).

## Address Structures
*   **struct sockaddr**: Generic address structure used by system calls.
*   **struct sockaddr_in**: IPv4-specific structure.
*   **struct sockaddr_in6**: IPv6-specific structure.
*   **struct sockaddr_storage**: Large enough to hold either IPv4 or IPv6 structures. Commonly used to allocate space and then cast to `struct sockaddr*`.

## Socket I/O
*   **read()**: Returns data already received by the network stack. If no data is waiting, it **blocks**. Returns `0` if the connection is closed.
*   **write()**: Enqueues data in the OS send buffer. If the buffer is full, it **blocks**. The OS transmits the data in the background.
*   **close()**: Shuts down the socket on both ends.

# Related
- [[CSE461/Transport/Transport Layer - Transmission Control Protocol (TCP)|CSE461: TCP]]
