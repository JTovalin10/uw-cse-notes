# Execution Environments and Virtualization: Process Sharing vs VM Sandboxing Walkthrough

## Walkthrough 2: Multi-Tenant Failure Scenario: Process Sharing vs. Virtual Machine Sandboxing

A buggy tenant script executes an unbounded fork-bomb on a shared physical server:

```
Scenario: Tenant executes infinite recursive process fork: `:(){ :|:& };:`

Outcome A: Under Linux Process Sharing (No Hypervisor)
  1. Script rapidly spawns processes exponentially: 1 -> 2 -> 4 -> 8 -> 1024 -> 32,768.
  2. Within 200ms, the system exhausts the global Linux kernel process table (PID_MAX).
  3. Neighboring Tenant B (an e-commerce checkout service) attempts to fork a worker thread or spawn a shell:
     - OS returns error: EAGAIN (Resource temporarily unavailable / Cannot allocate memory).
  4. System administrator attempts to SSH into the machine to kill the rogue process:
     - SSH daemon fails: cannot fork a login shell.
  5. Result: COMPLETE CLUSTER OUTAGE on that host. Physical machine must be hard-power-cycled.

Outcome B: Under Virtual Machine Isolation (Hypervisor)
  1. Script executes inside VM 1.
  2. VM 1's Guest OS process table exhausts its private PID_MAX limit.
  3. VM 1's internal Guest OS hangs or panics.
  4. The hypervisor limits VM 1 to its provisioned quota (e.g., 4 vCPUs and 8 GB RAM).
  5. Neighboring Tenant B in VM 2 is completely unaffected:
     - VM 2 uses its own private Guest OS process table.
     - Host hypervisor continues scheduling VM 2 smoothly.
  6. Operator issues a hypervisor API call to terminate or reboot VM 1.
  7. Result: Failure blast radius is strictly contained to the offending tenant.
```

## Related

- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Hub for this topic
- [[Datacenter Systems/Execution Environments and Virtualization/Live VM Migration Walkthrough|Live VM Migration Walkthrough]] — Migration during a host kernel upgrade
- [[Datacenter Systems/Execution Environments and Virtualization/Failure Modes|Failure Modes]] — Noisy neighbors, dirty-rate divergence, table exhaustion, and the virtualization tax
