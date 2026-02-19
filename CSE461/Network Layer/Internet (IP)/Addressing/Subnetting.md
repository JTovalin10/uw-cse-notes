Subnetting reduces the total number of network numbers that need to be assigned. A single IP network number is divided among several physical networks (subnets), giving the illusion of one network to outside routers — they only need one route to reach any of the subnets.

## Subnet Mask

The [[Subnet Mask]] is the mechanism that enables this. Every node on a subnet is configured with a subnet mask, which extracts the **subnet number** from an [[IP Address]] via bitwise AND. All hosts on the same physical network share the same subnet number.

![[Pasted image 20260215023104.png]]
![[Pasted image 20260215023143.png]]

## Sending

When a host wants to send to an IP address, it ANDs the destination address with its own subnet mask to get the destination's subnet number:
- **Same subnet number** → destination is local, deliver directly
- **Different subnet number** → forward to a [[Router]]

The [[Forwarding Table]] is extended with a **SubnetMask** field so routers can correctly match destinations to table entries.

See also: [[IP Address]], [[IP Global Addresses]], [[Classless Interdomain Routing (CIDR)]], [[IP Datagram Forwarding]]
