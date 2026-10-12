# Workloads and Software Infrastructure: Failure Modes

## Edge Cases, Failure Modes & Mitigations

### 1. Tail Latency Amplification in Scatter-Gather Tasks
- **Failure Mode**: In a fan-out query spanning $1,000$ leaf nodes, if a single node suffers a garbage collection pause or TCP retransmission, the overall query latency degrades to the $99.9\text{th}$ percentile straggler response time.
- **Mitigation**:
  - **Hedged Requests**: Send duplicate RPCs to a backup replica if no response is received within the $95\text{th}$ percentile latency threshold; use the first returning result and cancel the slower RPC.
  - **Tied Requests**: Enqueue cross-server tickets that cancel peer tasks automatically upon dequeue.

### 2. Noisy Neighbor Memory & Cache Contention
- **Failure Mode**: Co-located containers on the same physical host contend for shared L3 CPU cache lines and memory bus bandwidth, causing performance degradation for latency-sensitive online workloads.
- **Mitigation**: Resource management mechanisms like Intel RDT (Resource Director Technology) allocate dedicated L3 cache ways and enforce memory bandwidth quotas per container class.

### 3. Monitoring Alert Fatigue
- **Failure Mode**: Overly sensitive alert thresholds on high-frequency operational metrics generate constant false alarms, causing operators to ignore critical alerts during major outages.
- **Mitigation**: Base alerting strictly on Service Level Indicators (SLIs) linked directly to user impact (e.g., error rate and $99\text{th}$ percentile latency) rather than internal hardware utilization metrics.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Tail-Tolerance** | Straggler Mitigation / Hedged Requests / Speculative Execution |

## Related

- [[Datacenter Systems/Workloads and Software Infrastructure|Workloads and Software Infrastructure]] — Hub for this topic
- [[Datacenter Systems/Workloads and Software Infrastructure/Live VM Migration Trace|Live VM Migration Trace]] — Migration during host maintenance
- [[Datacenter Systems/Workloads and Software Infrastructure/Scatter-Gather Latency and Hedged Requests|Scatter-Gather Latency and Hedged Requests]] — Fan-out latency formulation and hedging
