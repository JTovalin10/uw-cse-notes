# CSE333: Sockets

A **[[Socket]]** is an abstraction for network communication, acting as an endpoint for sending or receiving data across a network. It is typically represented as a file descriptor in Unix-like systems.

## Communication Patterns
1. **Establish connection**
2. **Communicate**
3. **Close connection**

## Types of Sockets

### Stream Sockets (TCP)
**[[Stream Sockets]]** are used for connection-oriented, point-to-point, reliable byte stream communication. They ensure that data arrives in order and without errors.

### Datagram Sockets (UDP)
**[[Datagram Sockets]]** are used for connection-less, one-to-many, unreliable packet communication. They do not guarantee delivery or order but have lower overhead.
- Used for streaming media or DNS lookups.
- Building block with no flow control.

### Raw Sockets
Used for Layer 3 (Network Layer) communication.

## Network Roles
- **Client**: An application that initiates a connection to a server.
- **Server**: An application that waits for and receives connections from clients.
- **Peer-to-Peer**: Communication where nodes act as both clients and servers.

## Related
- [[CSE333/Networking/Socket Address]]
- [[CSE333/Networking/Socket API Client TCP Connection]]
- [[CSE333/Networking/Client-Side Networking]]
- [[CSE333/Networking/Server-Side Programming]]
