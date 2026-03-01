# Routing Overview

**Intradomain** routing — within one [[Autonomous System (AS)]]. Finding paths, building forwarding tables.

## Algorithms

| Type | Protocol | Notes |
|------|----------|-------|
| **Distance-vector** | [[Routing Information Protocol (RIP)]] | Bellman-Ford, 15-hop limit |
| **Link-state** | [[Open Shortest Path First (OSPF)]] | Dijkstra, flooding LSPs |

## Notes

- [[Routing]] — Forwarding vs routing, routing table vs forwarding table
- [[Distance-Vector Routing]] — How it works
- [[Link State Routing]] — How it works
- [[Route Calculation]] — Dijkstra
- [[Routing Metrics]] — Link cost
- [[Routing Areas (OSPF)]] — OSPF areas for scaling
- [[Spanning Tree Algorithm]] — For link-layer loops (learning bridges)
