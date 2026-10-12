# Course Introduction and Overview: Failure Modes

## Edge Cases, Failure Modes & Mitigations

### 1. The Straggler Effect (Tail Latency Amplification)
- **Failure Mode**: When an operation fans out to $N = 100$ parallel tasks, if even one leaf server experiences an OS background task pause, garbage collection cycle, or TCP packet retransmission, the entire parent request waits for that slowest node.
- **Mitigation**:
  - **Hedged Requests**: Send duplicate sub-requests to a secondary replica if no response is received within the 95th percentile window; cancel the slower request once the first returns.
  - **Tied Requests**: Replicate request tokens across multiple server queues simultaneously; when one server dequeues the request, it cancels the peer tickets.

### 2. Resource Stranding in Multi-Tenant Nodes
- **Failure Mode**: A physical node with 64 CPU cores and 256 GB RAM hosts multiple memory-intensive database containers allocating 256 GB RAM but utilizing only 8 CPU cores. The remaining 56 CPU cores cannot be rented to compute jobs requiring memory, resulting in stranded capital.
- **Mitigation**:
  - **Hardware Disaggregation**: Decoupling compute blades from shared pools of memory (via CXL interconnects) and storage (via NVMe-over-Fabrics), allowing independent scaling and allocation.
  - **Overcommit / Dynamic Resizing**: Provisioning burstable low-priority batch workloads (e.g., video transcoding, ML training) on stranded compute cycles.

### 3. Network Incast Congestion
- **Failure Mode**: A frontend node issues a parallel scatter-gather query to 50 leaf nodes. All 50 leaf nodes respond simultaneously, flooding the Top-of-Rack (ToR) switch port connected to the frontend node, causing packet buffer exhaustion and massive tail-drop packet loss.
- **Mitigation**:
  - Small switch buffer sizing paired with Explicit Congestion Notification (ECN) and Data Center TCP (DCTCP).
  - Paced response scheduling and receiver-driven flow control.

## Related

- [[Datacenter Systems/Course Introduction and Overview|Course Introduction and Overview]] — Hub for this topic
- [[Datacenter Systems/Course Introduction and Overview/Monolithic Appliance vs Cloud SaaS Trace|Monolithic Appliance vs Cloud SaaS Trace]] — End-to-end comparison trace
- [[Datacenter Systems/Course Introduction and Overview/Availability, Tail Latency, and PUE Formulas|Availability, Tail Latency, and PUE Formulas]] — Formal availability, fan-out tail latency, and PUE
