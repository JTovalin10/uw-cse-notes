network layer of the internet that uses [[Datagram model]]
- ipv4 carries 32 bit address on each packet
	- contains: version, header, total length, protocol, header checksum
	- some fields may differ to handle packet size differences
		- identification, fragment offset, fragment control bits
	- 
![[Screenshot 2026-02-09 at 12.51.15 PM.png]]
## Why do we need this
networks may differ
- service models
- addressing
- quality of service
- packet sizes
- security
Internetworking hides the differences with a common protocol