#define [[Switch]]: a mechanism that interconnects links to form a larger network; multi-input/output device that transfers packets from an input to one or more outputs

- Fixed number of I/O ports
- Connect switches to each other and to hosts using point-to-point links
- Adding new hosts doesn't necessarily reduce performance for existing hosts
- **More scalable than shared-media networks — can support multiple hosts at full speed**

![[Pasted image 20260214012918.png]]

# Primitives
- A switch is connected to a set of links, each running the appropriate data link protocol
- Primary job: receive incoming packets on one link and transmit them on another
	- Called **switching** or **[[Forwarding]]**

## Forwarding Strategies
How does a switch decide which output link to send each packet on? It reads an identifier in the packet header and uses one of three approaches:
- [[Connectionless|Datagram]] — full destination address, forwarded independently
- [[Virtual Circuit]] — connection-oriented, uses a [[Virtual Circuit Identifier|VCI]]
- [[Source Routing]] — sender specifies the full path (less common)

## Commonality Between All Networks
- All networks must identify end nodes using **addresses**
- We assume there is a way to identify the I/O port of each switch
