# Ports

Transport-layer demultiplexing key. An application process is identified by the tuple (IP address, transport protocol, port).

- **Ports** are 16-bit integers representing local "mailboxes" that a process leases
- **Servers** often bind to well-known ports (e.g., 80 for HTTP, 53 for DNS)
	- Ports < 1024 typically require admin privileges
- **Clients** are assigned ephemeral ports by the OS

## Related

- [[User Datagram Protocol (UDP)]] — uses ports for demultiplexing
- [[Transmission Control Protocol (TCP)]] — uses ports for demultiplexing