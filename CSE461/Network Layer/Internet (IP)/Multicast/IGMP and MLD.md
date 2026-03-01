# IGMP and MLD

Host-to-router protocols for joining/leaving multicast groups.

## Protocols

| Protocol | Used in |
|----------|---------|
| **IGMP** (Internet Group Management Protocol) | [[IPv4]] |
| **MLD** (Multicast Listener Discovery) | [[IPv6]] |

## How it works

- Host tells **local [[Router]]** it wants to join/leave a group
- Router is responsible for making multicast work for that host
- Router **periodically polls** to see which groups still have interest (handles host crashes)
