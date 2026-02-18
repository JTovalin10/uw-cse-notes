uses 128-bits instead of IPv4's 32-bit.
- features large addresses
	- 128 bits most of header
- new notation
	- 8 groups of 4 hex digits (16 digits)
	- omits leading zeros
- only public addresses
	- no more [[Network Address Translation (NAT) box]]
- streamlined header processing
	- no more [[CSE461/Link Layer/Error Detection and Correction/Checksum]]
- flow label to group packet
- IPSec by deafult
- can use better features
![[Screenshot 2026-02-18 at 12.59.22 PM.png]]
we still need [[Address Resolution Protocol (ARP)]] and [[CSE461/Network Layer/Internet (IP)/Dynamic Host Configuration Protocol (DHCP)]] but no longer need [[Network Address Translation (NAT) box]]

## Translation
IPv6 and IPv4 are fundamentally IPv4. We still need to support IPv4 so what we can do is:
1. dual stack (speak IPv4 and 6)
2. translators (convert packets)
3. [[Tunneling]]
## Downside
due to 128 bit it increases the size of packets