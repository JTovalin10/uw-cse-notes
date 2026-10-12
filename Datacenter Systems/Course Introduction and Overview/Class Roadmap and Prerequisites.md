# Course Introduction and Overview: Class Roadmap and Prerequisites

## Class Topics Roadmap

- [x] **Virtualization & Software-Defined Networking (SDN)**:
  - [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Providing cloud customers with the abstraction of having their own dedicated virtual datacenter that can scale elastically as needed.
- [ ] **Server, Storage, and Networking Hardware Technologies**:
  - Analyzing fundamental trade-offs between hardware cost, energy efficiencies, and low-latency performance.
- [ ] **Disaggregation**:
  - Eliminating resource stranding by pooling compute, memory, and storage across customers (vs. traditional per-server resource isolation).
- [ ] **Oversubscription, Congestion, and Queuing Theory**:
  - Predicting and modeling in advance how many shared resources are required to meet strict service expectations and latency targets.
- [ ] **Redundancy for High Availability**:
  - Mitigating hardware and network faults to maintain continuous cluster uptime.
- [ ] **Caching for Low Latency**:
  - Multi-tier caching hierarchies to bypass expensive storage and network hops.
- [ ] **Power, Cooling, and Carbon Footprint**:
  - Infrastructure thermal management, power distribution limits, and environmental impact.

---

## Assumptions About the Class (What It Expects You to Know)

- **Distributed System-Level Programming**:
	  - Hands-on systems programming dealing directly with **gRPC**, **Kubernetes**, and microservice orchestration.
	  - Core distributed concepts: [[Distributed Systems/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]], distributed consensus, replicated state machines, and RPC semantics.
- **Operating Systems**:
	  - **POSIX system call API** ([[Systems Programming/File IO and POSIX/System Calls|System Calls]]).
	  - **Networking interfaces, [[Operating Systems/Networking/Routing Tables|routing tables]]**, and kernel socket APIs.
	  - **File systems** and storage I/O subsystems.
	  - Virtual memory management ([[Operating Systems/Memory/Virtual Memory|Virtual Memory]]), page tables, and thread/process scheduling.
- **Computer Networking**:
	  - **Packet-oriented protocols**.
	  - **TCP/IP** (including [[Networking/Transport/Transport Layer - Transmission Control Protocol (TCP)|TCP]] flow and congestion control) and **Ethernet**.
	  - Packet-switched network architectures, switches, and routing protocols.
- **Computer Architecture**:
	  - Physical **hardware**, CPU **registers**, and register conventions.
	  - **PCIe** buses and DMA interconnects.
	  - Memory hierarchies (L1/L2/L3 CPU caches, DRAM) and memory buses.

## Related

- [[Datacenter Systems/Course Introduction and Overview|Course Introduction and Overview]] — Hub for this topic
- [[Datacenter Systems/Course Introduction and Overview/Primary Datacenter Engineering Concerns|Primary Datacenter Engineering Concerns]] — Core engineering concerns of datacenter design
- [[Datacenter Systems/Course Introduction and Overview/Monolithic Appliance vs Cloud SaaS Trace|Monolithic Appliance vs Cloud SaaS Trace]] — End-to-end comparison trace
