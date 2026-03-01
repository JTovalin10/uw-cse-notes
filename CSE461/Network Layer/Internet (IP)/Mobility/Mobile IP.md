# Mobile IP

Primary mechanism for routing to mobile hosts. No changes needed for most routers or correspondents.

## Addresses

| Address | Role |
|---------|------|
| **[[Home Address (Mobile IP)|Home address]]** | Permanent; prefix of home network; used by correspondents |
| **[[Care-of Address (Mobile IP)|Care-of address]]** | Temporary; on foreign network; changes when you move |

## Agents

| Agent | Location | Role |
|-------|----------|------|
| **[[Home Agent (Mobile IP)|Home agent]]** | On home network | Intercepts packets for mobile node, tunnels to care-of |
| **[[Foreign Agent (Mobile IP)|Foreign agent]]** | On foreign network | Receives tunneled packets, delivers to mobile node |

## How delivery works

1. **Correspondent** sends to home address → packet arrives at home network
2. **[[Home Agent (Mobile IP)|Home agent]]** intercepts via **proxy ARP** — answers ARP requests for the mobile's IP with its own MAC, so packets destined for the mobile are delivered to the home agent instead
3. **[[Home Agent (Mobile IP)|Home agent]]** tunnels packet to [[Care-of Address (Mobile IP)|care-of address]] ([[Foreign Agent (Mobile IP)|foreign agent]])
4. **[[Foreign Agent (Mobile IP)|Foreign agent]]** strips tunnel header, delivers to mobile node's hardware address

## Registration

- Mobile node attaches to foreign network, hears foreign agent advertisement
- Registers with [[Foreign Agent (Mobile IP)|foreign agent]] (gives [[Home Agent (Mobile IP)|home agent]] address)
- [[Foreign Agent (Mobile IP)|Foreign agent]] tells [[Home Agent (Mobile IP)|home agent]] the [[Care-of Address (Mobile IP)|care-of address]]

## Traffic from mobile → correspondent

- Mobile sends with **source = home address**, **dest = correspondent**
- Normal IP forwarding — no special handling

## Co-located care-of address

- Mobile node can **be** the [[Foreign Agent (Mobile IP)|foreign agent]] (run it itself)
- Needs to get IP on foreign network (e.g. DHCP)
- Works on networks without [[Foreign Agent (Mobile IP)|foreign agents]]
