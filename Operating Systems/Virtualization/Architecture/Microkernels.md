# CSE451: Microkernels

A **microkernel** is an OS design philosophy that takes the opposite approach from the [[Operating Systems/Virtualization/Architecture/OS Structure#Monolithic Architecture|Monolithic Architecture]]: rather than putting every subsystem into the kernel, a microkernel strips the kernel down to the bare minimum.

## Goal
- Minimize what goes in the kernel — ideally the kernel only contains the mechanisms that absolutely must run in [[Kernel Mode|Kernel Mode]], such as basic inter-process communication (IPC), minimal scheduling, and address space management.
- Organize the rest of the OS (file systems, device drivers, networking stacks, etc.) as user-level processes that run in [[User Mode|User Mode]] like ordinary applications, communicating with each other and with the kernel via IPC rather than direct function calls.

## Result
- Better reliability — because each OS service now runs as an isolated user-level process, a fault in one service (e.g., a crashing file system server) does not directly corrupt the kernel or other services, unlike in a monolithic kernel where all code shares the same address space and privilege level.
- Ease of extension and customization — since services are separate user-level processes, they can be added, removed, or replaced without recompiling or modifying the kernel itself.
- Poor performance — because services that used to be simple function calls within a monolithic kernel are now separate processes, every request between them requires crossing the user/kernel boundary (a [[Mode Switch|Mode Switch]]) and often multiple context switches, which is far more expensive than an in-kernel function call.

## Illustration
![[Pasted image 20260114214204.png]]

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Microkernel | Microkernel architecture (e.g., Mach, seL4, Minix) |
| User-level processes (for OS services) | User-space servers / userspace drivers |

## Related
- [[Operating Systems/Virtualization/Architecture/OS Structure|OS Structure]] — monolithic and layered architectures contrasted with the microkernel approach
- [[Operating Systems/Virtualization/Architecture/Major OS Components|Major OS Components]] — the components a microkernel moves out of the kernel
- [[Kernel Mode|Kernel Mode]] and [[User Mode|User Mode]] — the privilege boundary microkernel IPC must cross
- [[Mode Switch|Mode Switch]] — the mechanism responsible for the microkernel's performance overhead