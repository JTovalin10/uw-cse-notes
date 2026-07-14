# CSE451: OS Structure

## Overview

The **[[Operating Systems/Virtualization/Architecture/Operating System|Operating System]]** sits between application programs and the hardware:
- It mediates access to hardware resources and abstracts away the ugliness of dealing with raw hardware directly.
- Programs request services from the OS via **[[Traps|Traps]]** or **[[Exceptions]]** — a synchronous, program-initiated transfer of control into the kernel.
- Devices request attention from the OS via **[[Interrupts|Interrupts]]** — an asynchronous, hardware-initiated transfer of control into the kernel.

![[Screenshot 2026-01-14 at 4.51.51 PM.png]]
![[Screenshot 2026-01-14 at 4.52.26 PM.png]]
![[Screenshot 2026-01-14 at 4.52.41 PM.png]]

## Monolithic Architecture

Traditionally, operating systems were built as a **monolithic** entity: the entire OS — process management, memory management, file systems, device drivers, networking — is compiled into a single large binary that runs together in [[Kernel Mode|Kernel Mode]], with no internal boundaries separating one subsystem's code from another's.

![[Pasted image 20260114213634.png]]

### Advantages
- The cost of module interaction is low, since any function in the kernel can call any other function directly (a simple function call) rather than having to cross a protection boundary.

### Disadvantages
- Hard to understand — with no enforced separation between subsystems, the code for one component can become tangled with another's.
- Hard to modify — a change in one subsystem can have unpredictable ripple effects on others since there's no isolation boundary preventing accidental interference.
- Unreliable — a bug in any single component (e.g., a faulty device driver) can crash the entire kernel, and therefore the entire system, since everything shares one address space and privilege level.
- Hard to maintain — as the codebase grows, the lack of internal structure makes it increasingly difficult to reason about correctness or safely add new features.

## Layered Architecture

To address the disorganization of the monolithic approach, the **Layered Architecture** imposes explicit structure: the OS is divided into layers, where each layer only calls down into the layer directly beneath it, and services are only provided upward to the layer directly above.

![[Pasted image 20260114213758.png]]

### Problems with Layering
- Imposes a strict hierarchical structure, but real systems are more complex than a clean hierarchy allows:
	- The file system requires virtual memory (VM) services (e.g., buffers) to hold data temporarily.
	- Virtual memory would like to use files for its backing store (e.g., swap files).
	- These two subsystems depend on each other in both directions, so strict layering isn't flexible enough to model the real dependency graph.
- Poor performance — each layer crossing has overhead associated with it, since a request must pass through every intermediate layer even if only the bottom layer's service is actually needed.
- Disjunction between model and reality — the system is modeled conceptually as a clean stack of layers, but it is not really built that way in practice, since implementers end up bypassing the strict layering to solve the circular-dependency problems above.

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Monolithic Architecture | Monolithic kernel (e.g., Linux, traditional UNIX) |
| Layered Architecture | Layered/tiered system design |
| Traps/Exceptions | Synchronous kernel entry (syscall/trap) |
| Interrupts | Asynchronous hardware interrupts (IRQ) |

## Related
- [[Operating Systems/Virtualization/Architecture/Operating System|Operating System]] — what the OS structure is organizing
- [[Operating Systems/Virtualization/Architecture/Microkernels|Microkernels]] — an alternative structure that minimizes what runs in the kernel
- [[Operating Systems/Virtualization/Architecture/Major OS Components|Major OS Components]] — the pieces being structured
- [[Traps|Traps]] and [[Exceptions]] — synchronous kernel entry mechanisms
- [[Interrupts|Interrupts]] — asynchronous kernel entry mechanism
- [[Kernel Mode|Kernel Mode]] — the privileged mode monolithic kernels run entirely within
