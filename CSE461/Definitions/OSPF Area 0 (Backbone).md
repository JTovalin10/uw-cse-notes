# OSPF Area 0 (Backbone)

In [[Open Shortest Path First (OSPF)|OSPF]] [[Routing Areas (OSPF)|routing areas]], **Area 0** is the **backbone area** — the central area to which all other areas connect.

## Key points

- All non-backbone areas must connect to Area 0 (directly or via [[OSPF Virtual Link|virtual links]])
- Traffic between two non-backbone areas must transit through the backbone
- A router in both the backbone and another area is an **[[Area Border Router (ABR)]]**

## Packet path across areas

When a packet travels from one non-backbone area to another:

1. Source network → backbone
2. Cross the backbone
3. Backbone → destination network

## See also

- [[Routing Areas (OSPF)]] — OSPF area hierarchy
- [[Open Shortest Path First (OSPF)]] — the protocol
- [[OSPF Virtual Link]] — connecting to Area 0 when not physically adjacent
