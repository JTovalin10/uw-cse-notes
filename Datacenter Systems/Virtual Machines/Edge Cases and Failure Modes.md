# Virtual Machines: Edge Cases and Failure Modes

## Edge Cases, Failure Modes & Mitigations

| Failure Mode / Edge Case | Architectural Root Cause | Hypervisor Mitigation Strategy |
| :--- | :--- | :--- |
| **Shadow Page Table Write Amplification** | Workloads performing heavy fork/exec sequences (e.g., compilation, shell scripts) continuously write to page tables, generating thousands of `#PF` write-protection traps per second. | **Hardware Nested Paging (EPT/NPT)**: Completely eliminates write-protection traps by moving 2D translation to hardware MMU silicon. |
| **2D Nested Page Walk Latency Storms** | Workloads with massive random memory footprints (e.g., in-memory databases like Redis) experience high TLB miss rates, suffering 24 memory lookups per miss. | **2MB Superpages (Huge Pages)**: Collapse the lowest page table level, reducing TLB miss latency by up to $58\%$. |
| **Double Paging Hazard** | The hypervisor swaps out host physical pages belonging to a VM while the guest OS simultaneously swaps out pages, causing severe I/O thrashing. | **Balloon Driver**: Cooperates with the guest OS kernel allocator, ensuring pages are evicted using native guest replacement policies before physical RAM is surrendered. |
| **Balloon Driver Memory Starvation** | The hypervisor over-inflates the balloon beyond available guest free memory, forcing the guest OS kernel into an Out-of-Memory (OOM) panic. | Hypervisors monitor guest kernel memory telemetry via virtio channels, setting safety thresholds that halt inflation before guest swap/OOM limits are reached. |
| **TLB Invalidation Thrashing on Context Switch** | Switching between hypervisor and guest historically required complete TLB flushes, destroying instruction and data cache warmness. | **Virtual Processor IDs (VPID)**: Hardware tags TLB entries with a unique VM context ID, allowing entries to persist across VM-Exits and VM-Entries. |

## Related

- [[Datacenter Systems/Virtual Machines|Virtual Machines]] — Hub for this topic
- [[Datacenter Systems/Virtual Machines/Memory Ballooning|Memory Ballooning]] — Overcommitment, double paging, and the balloon driver
