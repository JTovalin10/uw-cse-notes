- multiple computers on a LAN contend for network medium
	- Media Access Control (MAC) specifies how computer cooperates
	- This layer specifies how bits are packetized and NICs are addressed
- Data link passes information to physical layer then the physical layer passes it to the others physical layer which will then go into the data link
- Multiple Nics transmitting at the same time
	- if there is a signal in the wire then the NIC will back off and retry
		- keep 90-95% of payload with the algorithm
	- one nic will talk at a time

Ethernet Header [destination address, source address], Ethernet Payload [data]
[[Networking Physical Layer]]