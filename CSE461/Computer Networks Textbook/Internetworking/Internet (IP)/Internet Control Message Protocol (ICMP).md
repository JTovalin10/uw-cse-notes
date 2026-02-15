## Internet Control Message Protocol (ICMP)
IP is willing to drop datagrams but does not fail silently. **Internet Control Message Protocol (ICMP)** defines a collection of error messages that are sent back to the source host whenever a router or host is unable to process an IP datagram successfully.

ICMP also defines a handful of control messages that a router can send back to the source host:
- **ICMP-redirect** - tells the source host there is a better route to the destination

See also: [[IP Service Model]], [[IP Datagram Forwarding]]
