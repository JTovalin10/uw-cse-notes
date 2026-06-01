# Foreign Agent (Mobile IP)

In [[Mobile IP]], the **foreign agent** is a router on the **foreign network** (where the mobile is visiting) that receives tunneled packets from the [[Home Agent (Mobile IP)|home agent]] and delivers them to the mobile node.

## Key points

- Located on the foreign network
- Receives packets tunneled to the [[Care-of Address (Mobile IP)|care-of address]]
- Strips tunnel header and delivers to mobile's hardware address
- Advertises its presence so mobile nodes can discover it and register

## Co-located care-of

The mobile can act as its own foreign agent (no separate FA needed) when it obtains an IP on the foreign network directly (e.g., via DHCP).

## See also

- [[Mobile IP]] — overview
- [[Home Agent (Mobile IP)]] — sends tunneled packets
- [[Care-of Address (Mobile IP)]]
