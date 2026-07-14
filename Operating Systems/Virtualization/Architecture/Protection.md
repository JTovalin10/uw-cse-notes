# CSE451: Protection

**Protection** is a general [[Mechanism]] used throughout the operating system to guard shared resources from misuse. Because many processes share the same physical hardware, the OS must ensure that one process cannot interfere with another, whether by accident or by malicious intent.

## What Needs Protection
All resources need to be protected, including:
- **Memory** — preventing one process from reading or writing another process's memory.
- **Processes** — preventing one process from arbitrarily killing or controlling another.
- **Files** — preventing unauthorized reads or writes to files owned by other users.
- **Devices** — preventing uncoordinated or unauthorized access to hardware devices.
- **CPU time** — preventing a process from monopolizing the processor.
- ...and other shared resources managed by the OS.

## Why It Matters
Protection mechanisms help to detect and contain unintentional errors (e.g., a buggy program that writes past the end of its own buffer) as well as prevent malicious destruction (e.g., an attacker attempting to read another user's private data). Without protection, the [[Operating Systems/Virtualization/Architecture/Operating System Roles#1. The Referee: Resource Allocation and Protection|Referee role]] of the OS would be impossible to enforce, since any process could freely access or corrupt any resource.

```mermaid
flowchart LR
    subgraph P1 [Process A]
        A1[Data]
    end
    subgraph P2 [Process B]
        B1[Data]
    end
    subgraph OS [Operating System - Protection Mechanism]
        M[Referee: Enforces Boundaries]
    end
    subgraph HW [Shared Hardware]
        MEM[Memory]
        CPU[CPU]
        DEV[Devices]
    end
    P1 -->|(1) Request access| M
    P2 -->|(1) Request access| M
    M -->|(2) Grants only authorized access| MEM
    M -->|(2) Grants only authorized access| CPU
    M -->|(2) Grants only authorized access| DEV
    M -.->|(3) Blocks unauthorized cross-access| P1
    M -.->|(3) Blocks unauthorized cross-access| P2
```

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Protection | Access control / isolation |
| Malicious destruction | Security exploit / privilege escalation |
| Unintentional errors | Software bugs / faults |

## Related
- [[Operating Systems/Virtualization/Architecture/Operating System Roles|Operating System Roles]] — Protection implements the Referee role
- [[Mechanism]] — Protection is a mechanism, distinct from the specific policies it enforces
- [[Base and Bounds]] — a concrete memory protection mechanism
- [[Hardware Modes|Hardware Modes]] — dual-mode operation underlying protection enforcement