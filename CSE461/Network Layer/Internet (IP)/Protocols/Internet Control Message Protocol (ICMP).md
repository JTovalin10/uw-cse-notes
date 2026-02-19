problem: what happens when something goes wrong during forwarding?

## Summary
[[CSE461/Definitions/Internet Protocol (IP)|IP]] is willing to drop [[Datagram|datagrams]] but does not fail silently. **Internet Control Message Protocol (ICMP)** defines a collection of error messages that are sent back to the source host whenever a router or host is unable to process an IP datagram successfully.

ICMP also defines a handful of control messages that a router can send back to the source host:
- **ICMP-redirect** - tells the source host there is a better route to the destination

## what is it
it is a companion protocol to IP
- implmmeneted together
- sits on top of IP
provides error report and testing
- error is at router while forwarding
- also testing that host can use

## Errors
when an error occurs while forwarding
- it sends an ICMP error report back to the IP source
- it discards the problematic packet and the host needs to rectify
## Message Format
each carries
1. type
2. code
3. [[CSE461/Definitions/Checksum|Checksum]]
often carry the start of the offending packet as payload and each message is carried in an IP packet
![[Pasted image 20260218211213.png]]

See also: [[IP Service Model]], [[IP Datagram Forwarding]]
