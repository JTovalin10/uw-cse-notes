# CSE461: Encapsulation

**Encapsulation** is the process where each protocol layer wraps data with its own header information. The layer above does not care about these headers, but they are needed for the network to function. Each layer adds its header on send and strips it on receive.

![[Screenshots/Header.png]]

## Related
- [[Network Layer - Internetworking and IP]] — the encapsulation stack (Application → TCP/UDP → IP → Ethernet)
- [[Frame]] — the link-layer PDU, the outermost wrapper on a typical network
- [[Internet Protocol (IP)]] — adds the IP header (Network layer)
