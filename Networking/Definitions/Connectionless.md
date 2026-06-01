# CSE461: Connectionless

A **connectionless** networking model handles each packet independently with no prior setup. The sender can transmit at any time without establishing a connection first. Each packet carries the full destination address and is forwarded based on the switch's [[Forwarding Table]].

Opposite of connection-oriented models like [[Virtual Circuit (VC)]] switching. The Internet's [[Internet Protocol (IP)|IP]] layer is connectionless.

## Related
- [[Datagram]] — the packet unit used in connectionless delivery
- [[Virtual Circuit (VC)]] — the connection-oriented alternative
- [[Forwarding Table]] — used to route packets hop by hop
