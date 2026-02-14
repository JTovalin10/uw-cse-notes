Three approaches for how switches consume the port list in [[Source Routing]]:

- **Rotation**: Switch moves its entry to the back of the list
	- Advantage: Host B gets a copy of the complete header, which helps it figure out how to get back to host A
- **Stripping**: Switch removes the first entry after using it
	- Simpler, but destination loses the full path info
- **Pointer**: Header carries a pointer to the current "next port" entry — each switch just increments the pointer
	- Most efficient to implement since the header isn't modified beyond the pointer

![[Pasted image 20260214021941.png]]
In each case, `A` is the entry the current switch reads and `B` is the entry the next switch reads.
