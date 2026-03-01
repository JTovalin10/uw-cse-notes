# IP version 4 (IPv4)

Fourth version of [[Internet Protocol (IP)]]. Uses 32-bit addresses. See [[Internet Protocol (IP)#Prefix]] for prefix basics.

## Addressing

- **32-bit** — ~4.3 billion; dotted-quad (e.g., 18.31.0.1), each octet 0 ≤ n ≤ 255
- **CIDR notation** — `address/length` (e.g., 128.13.9.9/16); length = prefix bits
- **Classless** — replaced [[IP Address Classes (Classful Addressing)|classful A/B/C]]. See [[Classless Interdomain Routing (CIDR)]]

![[Classful IP Addressing.png]]

## IPv4 header

![[IPv4.png]]

- Version, header length, TOS, [[Time to Live (TTL)]], flags, fragment offset, protocol, [[Checksum]], source/destination addresses

## Key protocols

- [[IP Address Resolution Protocol (ARP)]] — L3 → L2 ([[Media Access Control (MAC)|MAC]]) resolution
- [[Dynamic Host Configuration Protocol (DHCP)]] — assigns addresses
- [[Network Address Translation (NAT) box]] — share one public address (workaround for exhaustion)

## See also

- [[IPv6]] — 128-bit successor
- [[IP Address]], [[IP Global Addresses]]
