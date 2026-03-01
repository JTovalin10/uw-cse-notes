# MPLS Destination-Based Forwarding

## How it works

- Router allocates a **label** per prefix, advertises (label, prefix) to neighbors via **Label Distribution Protocol**
- **LER (Label Edge Router)** — does full IP lookup, attaches label
- **LSR (Label Switching Router)** — looks at label only, swaps it, forwards
- **Label swap**: Incoming label → outgoing label + interface

## Key benefit

- **Exact match** on label vs **longest match** on IP address
- Simpler, faster lookup (label = array index)
- Path is **same** as normal IP routing — only forwarding algorithm changes

## FEC (Forwarding Equivalence Class)

- Set of packets that get **same forwarding treatment**
- Example: all packets matching prefix 18.1.1
- FECs can be formed by almost any criteria (e.g. per-customer)

## Enabling non-IP devices

- **ATM switches** — already do label swap (VCI/VPI); add IP control → LSR
- **Optical switches** — same idea → **GMPLS** (Generalized MPLS)

## Where is the label?

- **Ethernet/PPP**: "Shim" between L2 header and IP header
- **ATM**: In cell header (VCI/VPI fields)

## Overlay vs MPLS

- **Overlay**: Routers over ATM; each router has VC to every other → many adjacencies
- **MPLS**: LSRs run same routing as edge routers → fewer adjacencies, full topology view
