# CSE451: Operating System

An **operating system** is software that manages a computer's resources for its users and applications.

## What Are Some Challenges

### Portability
- For programs:
	- **Application Programming Interface (API)**
	- **Abstract Virtual Machine (AVM)**
- For the operating system:
	- **Hardware Abstraction Layer**

### Reliability
- Does the system do what it was designed to do?

### Availability
- What portion of time is the system working?
- **Mean Time To Failure (MTTF)**, Mean Time to Repair

### Security
- Can the system be compromised by an attacker?

### Privacy
- Data is accessible only to authorized users.

### Performance
- **Latency/response time** — how long does an operation take to complete?
- **Throughput** — how many operations can be done per unit of time?
- **Overhead** — how much extra work is done by the OS? (compared to doing it without the OS)
- **Fairness** — how equal is the performance received by different users?
- **Predictability** — how consistent is the performance over time?

### Backward and Forward Compatibility
- Can it run legacy apps? (think hospitals running Windows 98)
- How to accommodate growing or advancing hardware (word size or memory size)?

## Related
- [[Operating System Roles]] — referee, illusionist, and glue
- [[Mechanism]] — how an OS achieves its goals
- [[Policy]] — what goals the OS tries to achieve
- [[Kernel Mode]] — the privileged execution mode of the OS
- [[Hardware Abstraction Layer]] — OS component that hides hardware differences