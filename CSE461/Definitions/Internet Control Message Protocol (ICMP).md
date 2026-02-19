## Internet Control Message Protocol (ICMP)
A protocol used by [[CSE461/Definitions/Internet Protocol (IP)|IP]] to send error messages and control messages back to the source host when a router or host cannot process a [[Datagram]] successfully.

Examples:
- **ICMP-redirect** — tells the source host there is a better route to the destination
- **Destination unreachable** — the packet could not be delivered
- **Time exceeded** — [[CSE461/Definitions/Time to Live (TTL)|TTL]] reached 0
