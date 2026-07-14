# CSE451: Operating System

An **operating system** is software that manages a computer's resources for its users and applications. It acts as an intermediary between application programs and the underlying hardware, enforcing the [[Operating Systems/Virtualization/Architecture/Operating System Roles|Operating System Roles]] of referee, illusionist, and glue so that many programs can share one machine safely and conveniently. To do this well, an operating system must confront a set of recurring design challenges, each of which trades off against the others.

## What Are Some Challenges

### Portability
Portability is the challenge of making software run correctly across different underlying hardware or across different versions of the same OS, without having to be rewritten from scratch each time.
- For programs:
	- **Application Programming Interface (API)**: a standardized set of functions and system calls (e.g., `open()`, `read()`, `write()`) that a program can rely on regardless of the specific hardware underneath — this lets application source code be recompiled (or even run unmodified) on different machines.
	- **Abstract Virtual Machine (AVM)**: a software-defined execution environment (such as a language runtime) that presents the same interface to a program no matter what physical hardware it is really running on, giving even stronger portability than an API alone.
- For the operating system itself:
	- **[[Operating Systems/Virtualization/Architecture/Hardware Abstraction Layer|Hardware Abstraction Layer]]**: the OS component that isolates hardware-specific code from the rest of the kernel, so the bulk of the OS does not need to change when it is ported to new hardware.

### Reliability
- Does the system do what it was designed to do? A reliable system produces correct results consistently and does not silently corrupt data or crash under expected workloads.

### Availability
- What portion of time is the system working? Availability captures how often the system is usable versus down for failures or maintenance.
- **Mean Time To Failure (MTTF)**: the average time the system runs correctly before it fails.
- **Mean Time to Repair (MTTR)**: the average time it takes to recover the system after a failure. Both MTTF and MTTR together determine overall availability.

### Security
- Can the system be compromised by an attacker? Security is about preventing unauthorized users or malicious code from gaining privileges or capabilities they should not have, which ties directly into the [[Operating Systems/Virtualization/Architecture/Protection|Protection]] mechanisms the OS provides.

### Privacy
- Data is accessible only to authorized users. Privacy is distinct from security in that it focuses specifically on who is allowed to see or use data, rather than on preventing system compromise in general.

### Performance
Performance has several independent dimensions, and improving one can sometimes come at the cost of another:
- **Latency/response time** — how long does an operation take to complete, from the moment it is requested to the moment it finishes?
- **Throughput** — how many operations can be done per unit of time, i.e. the aggregate rate of work the system can sustain?
- **Overhead** — how much extra work is done by the OS compared to doing the same task without the OS getting involved (e.g., the cost of a system call boundary crossing)?
- **Fairness** — how equal is the performance received by different users or processes competing for the same resources?
- **Predictability** — how consistent is the performance over time, i.e. does the same operation reliably take about the same amount of time each time it runs?

### Backward and Forward Compatibility
- Can it run legacy apps? (think hospitals running Windows 98 on modern hardware because critical medical equipment software was never updated)
- How to accommodate growing or advancing hardware (e.g., a jump from 32-bit to 64-bit word size, or vastly larger memory sizes than the OS was originally designed to address)?

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| Application Programming Interface (API) | Syscall ABI / POSIX API |
| Abstract Virtual Machine (AVM) | Managed runtime / language VM (e.g., JVM, CLR) |
| Hardware Abstraction Layer | Board Support Package (BSP) / driver abstraction layer |
| Mean Time To Failure (MTTF) | MTTF / Reliability metric (SRE terminology) |
| Mean Time to Repair (MTTR) | MTTR (SRE terminology) |

## Related
- [[Operating System Roles]] — referee, illusionist, and glue
- [[Mechanism]] — how an OS achieves its goals
- [[Policy]] — what goals the OS tries to achieve
- [[Kernel Mode]] — the privileged execution mode of the OS
- [[Hardware Abstraction Layer]] — OS component that hides hardware differences
- [[Protection]] — mechanisms underlying the security challenge