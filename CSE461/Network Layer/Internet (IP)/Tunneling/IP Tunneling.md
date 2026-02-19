For backwards comptability between IPv4 and IPv6 we use IP tunneling
it is where IPv6 packets are tunnel across IPv4 networks
![[Pasted image 20260218212028.png]]
this acts as a single link accross IPv4 netrwork
## IP Tunneling
- A virtual point-to-point link between a pair of nodes that are actually separated by an arbitrary number of networks
- The virtual link is created within the router at the entrance to the tunnel
	- the entrance router is configured with the IP address of the router at the far end
- When the entrance router wants to send a packet over this virtual link:
	- it encapsulates the packet inside an IP datagram
	- **destination address** in the IP header = the router at the far end of the tunnel
	- **source address** = the encapsulating router

![[Pasted image 20260215025609.png]]

### Benefits
1. Security
2. Multicast routing
3. Ability to carry packets from protocols other than IP across an IP network

### Drawbacks
Tunneling increases the length of packets, which uses more bandwidth and may cause [[IP Fragmentation and Reassembly|fragmentation]].

See also: [[Virtual Private Networks (VPN)]], [[IP Packet Format]]
