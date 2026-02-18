## Subnetting
Subnetting allows us to reduce the total number of network numbers that are assigned.
- Take a single IP network number and allocate the IP addresses with that network number to several physical networks (subnets)
	- the subnets should be close to each other, which gives the illusion of a single network
		- a router will only need to select one route to reach any of the subnets
	- **Subnet mask**: the mechanism by which a single network number can be shared among multiple networks, involving configuring all the nodes on each subnet
		- allows us to introduce a **subnet number**; all hosts on the same physical network will have the same subnet number

![[Pasted image 20260215023104.png]]
![[Pasted image 20260215023143.png]]

### Sending
When a host wants to send a packet to a certain IP address, it performs a bitwise AND between its own subnet mask and the destination IP address, which results in the subnet number of the destination. If the result matches the sender's own subnet number, then the destination host is on the same subnet and the packet can be delivered directly.
- If they are not equal, then the packet needs to be sent to a router to be forwarded to another subnet
- We must adjust the [[Forwarding Table]] to support this by adding an extra parameter **SubnetMask** to find the right entry in the table

See also: [[IP Global Addresses]], [[Classless Interdomain Routing  (CIDR)]], [[IP Datagram Forwarding]]
