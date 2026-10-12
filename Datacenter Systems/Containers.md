# Datacenter Systems: Containers

**Containers** virtualize the operating system's system call interface instead of the hardware: a group of processes runs on one shared OS kernel but each group sees an isolated machine of its own. This hub links to the focused notes on how that isolation is built and how it compares with [[Datacenter Systems/Virtual Machines|Virtual Machines]].

## Topics

- [[Datacenter Systems/Containers/OS-Level Virtualization|OS-Level Virtualization]] — Why containers exist, virtualizing the syscall interface, and language-level virtualization
- [[Datacenter Systems/Containers/Namespace Isolation|Namespace Isolation]] — Per-container file systems, process IDs, network identity, and resource views
- [[Datacenter Systems/Containers/Cgroups|Cgroups]] — Resource weights and limits, and why shared kernel data structures remain a weakness
- [[Datacenter Systems/Containers/Containers vs Virtual Machines|Containers vs Virtual Machines]] — Performance, security, and cost trade-offs
- [[Datacenter Systems/Containers/Serverless Functions and Enclaves|Serverless Functions and Enclaves]] — The third and fourth execution models
- [[Datacenter Systems/Containers/Network Virtualization|Network Virtualization]] — Virtual IP and MAC addresses and packet encapsulation

## Related

- [[Datacenter Systems/Virtual Machines|Virtual Machines]] — The hardware-level alternative to containers
- [[Datacenter Systems/IO Virtualization|IO Virtualization]] — Virtual devices and interposition
- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Broad taxonomy of execution environments
- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure|Microservices, RPC, and Cloud Infrastructure]] — Docker and Kubernetes in the labs
- [[Operating Systems/Virtualization/Containers and Virt|Containers and Virtualization]] — CSE451 treatment of containers vs hypervisors
- [[Datacenter Systems/Index|Datacenter Systems Index]]
