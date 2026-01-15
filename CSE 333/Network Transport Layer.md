# Transmission Control Protocol (TCP)
- provides applications with reliable, ordered, congestion-controlled byte streams
	- sends streams data as multiple IP packets (sequencal number) and retransmits if necessary
	- when receiving, put packets back n order and detects missing packets
- A single host (IP) can have to 2^{16} ports
	- like apartment number
# Berkely Socket API
- **connect()**: clients connect to a server IP address + application port number
- **listen()**: server listens for client connection
- **accept()**: sever accepts client connection
- **read()**: servers read from each other
- **write()**: servers write from one another

# User Datagram Protocol (UDP)
- provides application with *unreliable* packet delivery
- Thin and simple layer on top of IP
	- Datagram is broken up to multiple IPS
	  
[[Network Layer (IP)]]
[[Network Transport Layer]]
[[Networking Physical Layer]]
[[Networking Data Link Layer]]

