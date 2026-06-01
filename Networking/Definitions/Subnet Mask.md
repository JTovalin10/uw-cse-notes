# Subnet Mask

A bitmask that divides an [[IP Address]] into network/subnet and host portions. Used with [[Subnetting]] to split a single IP network number among multiple physical [[Subnet|subnets]].

## How it works

- Bitwise AND of destination address with subnet mask → **subnet number**
- All hosts on the same physical network share the same subnet number
- Example: /24 (255.255.255.0) → first 24 bits = network+subnet, last 8 = host

## Sending decision

When a host sends to an IP address:
- **Same subnet number** → deliver directly (local)
- **Different subnet number** → [[Forwarding|forward]] to a [[Router]]

## See also

- [[Subnetting]] — subnet assignment, VLSM
- [[Subnet]] — subdivision of an IP network
- [[Classless Interdomain Routing (CIDR)]] — prefix notation (e.g., /24)
