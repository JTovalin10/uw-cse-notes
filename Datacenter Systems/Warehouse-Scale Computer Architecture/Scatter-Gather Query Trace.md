# Warehouse-Scale Computer Architecture: Scatter-Gather Query Trace

## Concrete Walkthrough & Execution Trace

### Execution Trace: Processing a Scaled Scatter-Gather Query in a WSC

The following trace illustrates how a request traverses WSC hardware building blocks and handles an intra-rack switch oversubscription bottleneck:

```
Initial Context:
  Root Gateway Node (Rack 1, Slot 2) receives client query requiring data aggregation across 100 leaf shards.
  Network Oversubscription: 4:1 ratio between rack internal links and cluster uplinks.

Trace Steps:
  1. [Gateway Node] Serialization & Fan-out:
     - Root Gateway serializes sub-queries into Protobuf messages.
     - Transmits 100 parallel RPCs across Rack 1 ToR Switch.

  2. [Network Fabric] Bisection Traversal:
     - 15 sub-queries target leaf nodes located inside Rack 1 (Local Intra-Rack traversal: 10 Gbps / 40 Gbps zero oversubscription).
     - 85 sub-queries traverse ToR Uplinks to Cluster Core Switch (Oversubscribed fabric).
     - Core switch routes packets to ToR switches in Racks 2 through 12.

  3. [Leaf Nodes] Parallel Processing & Storage Access:
     - Leaf nodes receive RPCs via local PCIe NICs.
     - Read target index partitions from local Flash SSD (DAS) with ~100 microsecond read latency.

  4. [Network Fabric] Network Incast & Response Aggregation:
     - All 100 leaf nodes transmit response payloads back to Gateway Node simultaneously.
     - Burst traffic causes temporary buffer accumulation at Rack 1 ToR Switch (Incast congestion).
     - ToR Switch applies Explicit Congestion Notification (ECN) to pace TCP window delivery.

  5. [Gateway Node] Completion & Response:
     - Gateway Node aggregates 100 partial responses into final payload.
     - Sends response back to client; total execution time: 12.4 milliseconds.
```

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Cluster Switch** | Spine Switch / Core Switch / Fabric Interconnect |

## Related

- [[Datacenter Systems/Warehouse-Scale Computer Architecture|Warehouse-Scale Computer Architecture]] — Hub for this topic
- [[Datacenter Systems/Warehouse-Scale Computer Architecture/Hardware Building Blocks|Hardware Building Blocks]] — Servers, storage, and networking fabric
- [[Datacenter Systems/Warehouse-Scale Computer Architecture/Failure Modes|Failure Modes]] — Faults, bisection bandwidth, and thermal limits
