packet contain a destination address; each router uses it to forward packets, maybe on different paths
![[Screenshot 2026-02-09 at 12.45.02 PM.png]]
note: its possible that packets can reach one before another if one link is faster than another

Each router has a forwarding table keyed by address
- each hop for each address; may change
![[Screenshot 2026-02-09 at 12.47.10 PM.png]]