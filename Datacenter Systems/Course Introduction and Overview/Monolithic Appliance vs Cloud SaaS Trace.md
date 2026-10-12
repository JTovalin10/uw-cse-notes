# Course Introduction and Overview: Monolithic Appliance vs Cloud SaaS Trace

## Concrete Walkthrough & Execution Trace

### End-to-End Execution Trace: Monolithic Appliance vs. Cloud SaaS

Consider an enterprise record update (e.g., updating a patient medical chart):

```
Scenario: Updating record ID #84920 under peak user load

Approach A: Turnkey Appliance (On-Premises Box)
  1. Client sends update over local LAN to appliance box.
  2. Local appliance CPU processes business logic directly on single node.
  3. Writes to internal RAID-10 disk array; synchronous fsync blocks processing.
  4. Appliance enqueues asynchronous billing/telemetry RPC to vendor datacenter.
  Failure Mode: If the appliance power supply fails or motherboard fries, 
                the entire hospital unit halts until a technician replaces physical hardware.

Approach B: Cloud SaaS (Hyperscale Datacenter)
  1. Client sends TLS HTTP/2 request to Cloud Anycast IP.
  2. Cloud Border Router routes packet to nearest edge datacenter via BGP.
  3. Load balancer terminates TLS and forwards request over internal SDN to an API Gateway Pod.
  4. API Gateway parses Protobuf payload and fans out gRPC requests:
       - Auth Service: Validates token against distributed cache (0.8ms).
       - Billing Service: Enqueues transaction to distributed log (1.2ms).
       - Storage Service: Replicates update across 3 availability zones via Paxos/Raft (4.5ms).
  5. API Gateway aggregates responses and returns HTTP 200 OK to client (total elapsed: 7.1ms).
  Resilience: If a physical server crashes mid-flight, container orchestrator (Kubernetes) 
              reschedules pods instantly, and storage replicas complete write transparently.
```

## Related

- [[Datacenter Systems/Course Introduction and Overview|Course Introduction and Overview]] — Hub for this topic
- [[Datacenter Systems/Course Introduction and Overview/Class Roadmap and Prerequisites|Class Roadmap and Prerequisites]] — Class topics and expected background
- [[Datacenter Systems/Course Introduction and Overview/Failure Modes|Failure Modes]] — Stragglers, resource stranding, and incast
