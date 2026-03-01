# MPLS VPNs and Tunnels

## MPLS as tunneling

- MPLS header acts like tunnel header (shorter than IP — 4 bytes vs 20)
- Can carry **any** data, not just IP
- **Label stacking** — multiple labels on one packet

## Layer 2 VPN (pseudowire)

- Tunnel L2 data (Ethernet, ATM cells) across MPLS network
- **Head router**: Incoming port+VCI → demux label + tunnel label
- **Tail router**: Strip labels, send out correct port with new VCI
- Emulates circuits (ATM, Frame Relay, Ethernet)

## Layer 3 VPN

- Tunnel **IP packets** across provider network
- Provider gives each customer a "virtually private" IP network
- Customers isolated — can't reach each other, can reuse addresses
- Tunnels configured automatically via BGP
