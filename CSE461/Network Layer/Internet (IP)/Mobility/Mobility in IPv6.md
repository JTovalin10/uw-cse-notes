# Mobility in IPv6

## Differences from IPv4

- Mobility built into IPv6 from start (no incremental deployment hacks)
- **No [[Foreign Agent (Mobile IP)|foreign agent]]** — every IPv6 host can get an address on the foreign network via **SLAAC** (Stateless Address Autoconfiguration) or DHCPv6
- Mobile node acts as its own "[[Foreign Agent (Mobile IP)|foreign agent]]"

## Optimized routing with extension headers

- Instead of **tunneling** to [[Care-of Address (Mobile IP)|care-of]], send packet to care-of with **routing header** containing home address
- Intermediate routers ignore routing header
- Mobile node treats packet as if sent to home address
- **More efficient** than tunnel (less overhead)
