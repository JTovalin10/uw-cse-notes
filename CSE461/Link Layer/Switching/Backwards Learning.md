Switch forwards frames with a port/address table as follows:
1. To fill the table, it looks at the source address of input frames
2. To forward, it sends to the port, or else broadcasts to all ports
![[Screenshot 2026-02-06 at 12.51.00 PM.png]]
## Problem with forwarding loops
we may have a loop in the topology
- creates redundancy in case of failure
- may be a simple mistake
We want LANS to just work
- plug and play, it changes host itself
- however loops are an issue we must consider
