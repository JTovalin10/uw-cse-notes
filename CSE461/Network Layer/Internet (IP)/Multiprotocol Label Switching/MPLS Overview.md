# MPLS Overview

## What is MPLS?

- Combines **virtual circuit**-like forwarding (labels) with **IP** routing/control
- Routers forward by **label** (short, fixed-length) instead of IP longest-match
- Labels have **local scope** (like VC identifiers)

## What is it used for?

1. **IP on non-IP devices** — e.g. ATM switches, optical switches (can't do IP lookup)
2. **Explicit routing** — precalculated paths that may differ from normal IP routing
3. **VPNs** — virtual private network services

## What it's NOT used for

- **Performance** — modern IP routers are fast enough; not a main goal anymore
