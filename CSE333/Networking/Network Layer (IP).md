- Internet Protocol (IP) routes packages across multiple networks
	- Every computer has a unique IP
	- Networks are connected by routers that span networks
# packet encapsulation
- IP packet is encapsulated as payload of an ethernet frame
- up packet traverse networks, routers pull out the IP packet from an Ethernet frame and plunk it into a new one on the next network
Eternet payload: data
data = <IP header, IP payload>
---\host{ip}/---...
	| {eternet id}
	|
   router
     |
     | {eternet id}
-----\host{IP}/---...



[[Networking Data Link Layer]]
[[Networking Physical Layer]]
