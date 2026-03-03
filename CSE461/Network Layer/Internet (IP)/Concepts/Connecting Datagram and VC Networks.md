# Connecting Datagram and VC Networks

When interconnecting [[Datagram model|datagram]] and [[Virtual Circuit (VC)|virtual circuit]] networks, we need to map destination addresses to VCs and vice versa.

- A complication: a VC may need to be set up before traffic can flow
- The gateway between the two network types must translate between address-based forwarding (datagram) and circuit-based forwarding (VC)

![[Screenshot 2026-02-09 at 12.53.21 PM.png]]

## Related

- [[Datagram model]] — connectionless forwarding
- [[Virtual Circuit (VC)]] — connection-oriented forwarding