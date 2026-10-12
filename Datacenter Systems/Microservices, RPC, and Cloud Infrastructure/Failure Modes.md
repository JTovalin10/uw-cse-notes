# Microservices: Failure Modes

## Edge Cases, Failure Modes & Mitigations

### 1. Protobuf Field Tag Collisions & Schema Drift
- **Failure Mode**: A developer changes the data type of an existing field tag or reuses an obsolete tag number. Older clients parsing messages with updated schemas will suffer silent data corruption or deserialization panics.
- **Mitigation**:
  - Never reuse or renumber numeric field tags.
  - Mark deprecated fields as `reserved`:
    ```proto
    message UserProfile {
      reserved 2, 5 to 8;
      reserved "obsolete_field";
      string name = 1;
    }
    ```

### 2. Microservice Cascading Timeouts & Thread Starvation
- **Failure Mode**: Service A calls Service B, which calls Service C. If Service C hangs due to a database lock, Service B blocks, exhausting its connection pool and goroutines. Service A subsequently exhausts its workers, cascading failure across the entire cluster.
- **Mitigation**:
  - Always enforce explicit deadline timeouts using Go contexts (`context.WithTimeout`).
  - Implement circuit breakers to fail fast when downstream dependencies stop responding.

### 3. Container OOMKilled by Linux Cgroups
- **Failure Mode**: A memory-intensive Go microservice allocates memory beyond the `resources.limits.memory` defined in its container spec. The Linux kernel OOM (Out-of-Memory) killer immediately terminates the process with exit code 137 (`SIGKILL`).
- **Mitigation**:
  - Configure the Go runtime memory target (`GOMEMLIMIT`) to trigger garbage collection before reaching the hard cgroup threshold.
  - Set container memory requests and limits with adequate safety margins.

### 4. Cloud Credit Exhaustion via Idle VM Instances
- **Failure Mode**: Leaving multi-core cloud VM instances and attached persistent SSD storage disks running 24/7 drains lab project credits rapidly.
- **Mitigation**:
  - Stop VM instances via the GCP Console or CLI immediately upon concluding testing:
    ```bash
    gcloud compute instances stop <instance-name> --zone=<zone>
    ```

## Related

- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure|Microservices]] — Hub for this topic
- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/gRPC Call Trace|gRPC Call Trace]] — A full gRPC call from client to server
