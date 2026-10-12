# Datacenter Systems: The Popek-Goldberg Virtualization Theorem

The Popek-Goldberg Virtualization Theorem defines the precise mathematical and architectural requirements an Instruction Set Architecture (ISA) must satisfy to support a Virtual Machine Monitor (VMM) using direct execution.

## Topics

- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Requirements and System Model|Requirements and System Model]] — Core requirements, assumptions, and instruction classification
- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Trap-and-Emulate Mechanism and Traces|Trap-and-Emulate Mechanism and Traces]] — How traps are emulated, with an interrupt trace
- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Architectural Violations and Mitigations|Architectural Violations and Mitigations]] — Classic ISAs that break the theorem and their fixes
- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Virtual IO Emulation and Virtio|Virtual IO Emulation and Virtio]] — Full I/O emulation versus paravirtualized virtio
- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Formal Definition|Formal Definition]] — Formal statement of the theorem
- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/VT-x and EPT Extensions|VT-x and EPT Extensions]] — Hardware-assisted extensions

## Related

- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Master course document detailing datacenter virtualization, workload taxonomy, hypervisor memory management, and live migration.
- [[Operating Systems/CSE451 Index|CSE451 — Operating Systems]] — Kernel dual-mode privilege boundaries, hardware exception traps, interrupt vectors, and virtual memory paging.
- [[Hardware & Software Interface/CSE351 Index|CSE351 — Hardware & Software Interface]] — Machine-level ISA specification, register files, processor control flags, and address translation hardware.
