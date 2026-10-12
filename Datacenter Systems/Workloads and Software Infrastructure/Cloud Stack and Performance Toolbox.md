# Workloads and Software Infrastructure: Cloud Stack and Performance Toolbox

## Cloud Computing Stack & Multi-Tenancy

Public cloud platforms leverage WSC cluster infrastructure to deliver elastic compute services:

![[Screenshots/Overview of VM-based Software Stack for GCP Workloads.png]]

- **I/O Virtualization**: Guest OS I/O operations pass through hypervisor abstraction layers to execute on physical host hardware.
- **High Availability ($N+1$ Redundancy)**: Multi-region redundancy ensures continuous service availability during planned system updates or physical hardware failures.
- **Resource Isolation**: Enforces CPU, memory bandwidth, and network QoS to prevent malicious or heavy "noisy neighbor" workloads from degrading peer tenant performance.
- **Zero-Trust Information Security**: WSCs implement multi-layer physical perimeter controls (biometric scanners, laser intrusion detection, vehicle barriers) combined with mandatory internal network TLS encryption and hardware Root of Trust chips (e.g., Google Titan).

## Performance and Availability Toolbox

WSC engineering employs a standardized set of operational patterns to guarantee performance and resilience:

![[Screenshots/WSC Performance and Availability Toolbox - Part 1.png]]

![[Screenshots/WSC Performance and Availability Toolbox - Part 2.png]]

![[Screenshots/WSC Performance and Availability Toolbox - Part 3.png]]

![[Screenshots/WSC Performance and Availability Toolbox - Part 4.png]]

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Noisy Neighbor** | Resource Contention / Cross-Tenant Interference |

## Related

- [[Datacenter Systems/Workloads and Software Infrastructure|Workloads and Software Infrastructure]] — Hub for this topic
- [[Datacenter Systems/Workloads and Software Infrastructure/Workload Diversity|Workload Diversity]] — Production application mechanics
- [[Datacenter Systems/Workloads and Software Infrastructure/Live VM Migration Trace|Live VM Migration Trace]] — Migration during host maintenance
