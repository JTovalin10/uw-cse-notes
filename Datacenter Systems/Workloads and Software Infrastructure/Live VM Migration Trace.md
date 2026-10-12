# Workloads and Software Infrastructure: Live VM Migration Trace

## Concrete Walkthrough & Execution Trace

### Execution Trace: Live VM Migration During Physical Host Maintenance

The following trace demonstrates how cluster software migrates a running guest virtual machine to a secondary physical server without interrupting live client TCP connections:

```
Scenario: Physical Host Alpha requires emergency kernel security patching.
Target: Migrate Guest VM #402 to Host Beta with zero client-perceived downtime.

Trace Steps:
  1. [Cluster Scheduler] Target Allocation:
     - Scheduler selects Host Beta with matching CPU/RAM capacity in the same rack domain.

  2. [Hypervisor Alpha] Pre-Copy Phase (Iterative Memory Transfer):
     - Hypervisor Alpha snapshots dirty memory pages of Guest VM #402.
     - Copies base memory pages over cluster network to Host Beta while VM remains active.
     - Tracks newly dirtied pages during transfer using write-protection page table flags.

  3. [Hypervisor Alpha] Final Stop-and-Copy Phase (<50ms):
     - Pause Guest VM #402 execution briefly.
     - Transmits final delta of dirty memory pages and CPU register state to Host Beta.

  4. [SDN Controller] Network State Handoff:
     - Software-Defined Networking (SDN) controller updates virtual switch routing rules.
     - Re-routes incoming Virtual IP (VIP) packets from Host Alpha ToR switch port to Host Beta ToR switch port.

  5. [Hypervisor Beta] Execution Resume:
     - Host Beta restores CPU register state and resumes VM execution.
     - Client connections remain open; TCP sequence numbers continue without drop.
```

## Related

- [[Datacenter Systems/Workloads and Software Infrastructure|Workloads and Software Infrastructure]] — Hub for this topic
- [[Datacenter Systems/Workloads and Software Infrastructure/Cloud Stack and Performance Toolbox|Cloud Stack and Performance Toolbox]] — Multi-tenancy and the performance and availability toolbox
- [[Datacenter Systems/Workloads and Software Infrastructure/Failure Modes|Failure Modes]] — Tail latency, noisy neighbors, and alert fatigue
