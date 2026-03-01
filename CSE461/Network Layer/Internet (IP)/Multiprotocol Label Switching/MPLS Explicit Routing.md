# MPLS Explicit Routing

## What is it?

- Forward packets along **precalculated paths** that may differ from normal IP routing
- Like source routing, but usually a **router** (not the source) picks the route

## How it works

- Different **FECs** get different labels → different paths
- Use **RSVP** to set up label forwarding along an explicit path (like VC setup)
- Example: R1→R7 traffic goes R1-R3-R6-R7; R2→R7 goes R2-R3-R4-R5-R7

## Applications

- **Traffic engineering** — control which paths traffic uses
- **Fast reroute** — precalculate backup path avoiding link L; on L failure, use backup immediately (no wait for routing convergence)

## CSPF (Constrained Shortest Path First)

- Link-state algorithm with **constraints**
- Example: Find path with ≥100 Mbps available capacity
