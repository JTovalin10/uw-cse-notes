# Datacenter Systems: Quiz 4

Notes on load testing and finding bottlenecks in the microservices lab (see [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Microservices, RPC, and Cloud Infrastructure|Microservices, RPC, and Cloud Infrastructure]]).

---

## Load Generation Models

- **Closed-loop**: a new request is only triggered by the completion of a previous request.
- **Open-loop**: new requests are triggered independently of previous completions.

## Finding the Overload Point

- The system is **overloaded** when latency starts increasing at a specific microservice.
- To find it:
  - Set different levels of load.
  - Then do a **binary search** to gather at least 10 different load points, ranging from 0 to the overload point.

## Finding the Bottleneck

- The bottleneck service's **queue should grow unboundedly**, ideally.
- It is hard to measure the queue length directly, so we **intercept gRPC requests** and use their latencies as proxies (see [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/gRPC and Protocol Buffers|gRPC and Protocol Buffers]]).
- Get the gRPC latencies with:
  - `kubectl logs <frontend-pod-name>`

## Scaling

- Scaling gives **diminishing returns**.
- For this assignment, find the diminishing returns in terms of the **max point shift** (how far the overload point moves as we add capacity).

---

## Related

- [[Datacenter Systems/Queuing Theory/Queuing Theory|Queuing Theory]]: response time versus utilization
- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Docker and Kubernetes|Docker and Kubernetes]]

## Industry Standard Terms

- **Closed-loop / open-loop** → closed-loop / open-loop load generation (open-loop avoids coordinated omission)
- **Overload point** → saturation point / knee of the latency curve
- **Max point shift** → change in saturation throughput after scaling
