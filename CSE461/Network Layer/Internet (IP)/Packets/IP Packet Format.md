## IP Packet Format
![[Pasted image 20260215015819.png]]
- **Version**
	- IPv4 or IPv6
	- this is at the start so the processing software can adjust its code based on the version
- **HLen**
	- length of header in 32-bit words (if no options then header is 20 bytes)
- **TOS (Type of Service)**
	- allows packets to be treated differently based on application needs
- **Length**
	- length of the [[Datagram]] including header, counted in bytes rather than words (max is 65535 bytes)
- **[[CSE461/Definitions/Time to Live (TTL)]]**
	- catches packets that have been going around in routing loops and discards them so they don't keep using resources (default = 64)
	- each hop decrements it by 1 and when it reaches 0 the packet is discarded
- **Flags**
	- used later
	- M flag means there are more fragments to follow
- **Offset**
	- when setting this it is always in 8-byte chunks, so divide n-bytes / 8
- **Protocol**
	- demultiplexing key that identifies the higher-level protocol to which this IP packet should be passed
	- 6 = [[Transmission Control Protocol (TCP)|TCP]]
	- 17 = [[User Datagram Protocol (UDP)|UDP]]
- **[[Checksum]]**
- **SourceAddr**
- **DestinationAddr**
	- this is key for [[Datagram]] delivery where every packet contains the full address of its intended destination so that forwarding decisions can be made at each router

See also: [[IP Service Model]], [[IP Fragmentation and Reassembly]]
