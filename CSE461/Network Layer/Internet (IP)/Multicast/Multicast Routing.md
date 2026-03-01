# Multicast Routing

[[Router|Routers]] need **multicast [[Forwarding Table|forwarding tables]]** — which links to [[Forwarding|forward]] on (possibly multiple). Unicast = one path; multicast = tree (multiple branches).

## Multicast distribution trees

- **Shared tree** — one tree for all senders
- **Source-specific tree** — tree rooted at a specific sender

## DVMRP (Distance Vector Multicast Routing Protocol)

- **Flood-and-prune**: First flood to all, then prune networks with no group members
- Uses **Reverse Path Broadcast (RPB)** — forward only if packet arrived on shortest path to source
- **Parent router** per link per source — only parent forwards (avoids duplicate packets on LAN)
- Pruning: leaf networks with no members advertise "no interest"; info propagates up

## PIM-SM (Protocol Independent Multicast — Sparse Mode)

- **Dominant** protocol today
- **Routers explicitly join** (no flood first)
- **Rendezvous Point (RP)** — special router per group; receivers join toward RP
- **Shared tree** first, then **source-specific tree** if traffic warrants
- **Protocol independent** — works with any unicast [[Routing]]
- Sender sends to RP via **Register** ([[IP Tunneling Overview|tunnel]]); RP forwards on shared tree

## PIM-SSM (Source-Specific Multicast)

- **Channel** = (source S, group G)
- Host specifies both in IGMP; router joins source-specific tree directly

**Benefits:**
- More direct paths
- Same group address reusable across domains (different sources)
- Less attack surface (only specified source can send)
- Works across domains without MSDP

## MSDP (Multicast Source Discovery Protocol)

- Connects **RPs across domains** (each domain has own RP)
- RPs exchange **Source Active** messages (who is sending to which group)
- RP with receivers sends source-specific Join to source

## BIDIR-PIM

- **Bidirectional** — traffic flows both up and down tree
- Good for many-to-many (e.g. videoconference)
- No actual RP needed — just an "RP address" (routable)
- No source registration; less state than PIM-SM
- **Within domain only** (no interdomain)
