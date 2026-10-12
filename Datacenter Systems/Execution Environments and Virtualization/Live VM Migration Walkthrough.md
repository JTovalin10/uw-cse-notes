# Execution Environments and Virtualization: Live VM Migration Walkthrough

## Walkthrough 1: Live VM Migration During a Host Kernel Upgrade

Consider a physical server (`Host A`) running a critical enterprise database VM (`VM 1`). The datacenter operator must apply an urgent Linux kernel security patch to `Host A`, which requires a full system reboot.

```
Scenario: Performing Zero-Downtime Host Maintenance via Pre-Copy Live Migration

Initial State (t = 0):
  Host A: Running VM 1 (active memory: 32 GB, dirtying pages at 50 MB/s).
  Host B: Destination physical server with idle capacity.
  Storage: Virtual disk resides on remote NVMe-oF network storage.

Trace:
  1. t = 1: Migration Initialization
     - Hypervisor on Host A establishes a high-speed TCP/RDMA migration connection to Host B.
     - Host B allocates a 32 GB memory container and configures virtual hardware devices.

  2. t = 2: Pre-Copy Iteration 1
     - Host A marks all physical memory pages of VM 1 as read-only or tracks writes via EPT dirty bits.
     - Host A transmits all 32 GB of memory across the 100 Gbps datacenter network to Host B.
     - VM 1 continues executing uninterrupted on Host A, processing user queries and dirtying memory pages.

  3. t = 3: Iterative Dirty Page Sync
     - Iteration 2: Host A sends only the pages dirtied during Iteration 1 (e.g., 2 GB).
     - Iteration 3: Host A sends pages dirtied during Iteration 2 (e.g., 200 MB).
     - Loop continues until dirty page rate converges below transfer threshold.

  4. t = 4: Stop-and-Copy Phase (The Sub-Second Switchover)
     - Host A briefly pauses VM 1 execution (downtime window: ~15 to 30 milliseconds).
     - Host A transfers final CPU register state (%rax, %rsp, %rip, control registers) and remaining dirty pages.
     - Host A ceases executing VM 1.

  5. t = 5: Activation on Host B
     - Host B loads CPU registers and resumes VM 1 execution instantly from the exact instruction where it paused.
     - Host B sends a Gratuitous ARP (GARP) broadcast to the Top-of-Rack (ToR) network switch:
       "VM 1's MAC address is now located on Switch Port B."
     - Network switch redirects incoming TCP packets to Host B. Clients experience a momentary ~20ms latency hiccup, with zero dropped TCP connections.

  6. t = 6: Host A Maintenance
     - Host A is now completely vacant.
     - Operator reboots Host A, applies kernel security patch, verifies firmware, and returns node to production pool.

Total Application Downtime: 22 milliseconds (completely transparent to end users).
```

## Related

- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Hub for this topic
- [[Datacenter Systems/Execution Environments and Virtualization/Operational Capabilities of Virtual Machines|Operational Capabilities of Virtual Machines]] — Snapshots, migration, and management advantages
- [[Datacenter Systems/Execution Environments and Virtualization/Process Sharing vs VM Sandboxing Walkthrough|Process Sharing vs VM Sandboxing Walkthrough]] — Multi-tenant failure scenario comparison
