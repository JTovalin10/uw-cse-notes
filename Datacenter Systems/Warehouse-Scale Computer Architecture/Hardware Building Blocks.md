# Warehouse-Scale Computer Architecture: Hardware Building Blocks

## Hardware Building Blocks

WSCs construct computing capacity using modular, standardized hardware units stacked hierarchically.

![[Screenshots/Hardware Building Blocks for WSCs.png]]

![[Screenshots/Hardware Building Blocks Assembled.png]]

### 1. Servers
- **Form Factor**: Standardized 1U or blade enclosure servers mounted in 19-inch or 21-inch custom racks.
- **Rack Integration**: Each rack houses dozens of server nodes connected to a local Top-of-Rack (ToR) Ethernet switch via 40 Gbps or 100 Gbps links.
- **Internal Bus**: Blade enclosures utilize PCIe links for high-speed internal communication between processing blades and networking modules.

### 2. Storage Architecture
WSC storage balances cost, bandwidth, latency, and durability using hard disk drives (HDDs) and Flash Solid-State Drives (SSDs):

- **Direct-Attached Storage (DAS)**: Disks and SSDs physically attached directly to compute nodes. Reduces hardware cost and improves network utilization by eliminating specialized storage fabrics.
- **Network-Attached Storage (NAS)**: Dedicated storage nodes accessible over the cluster network. Simplifies storage management and provides strict Quality of Service (QoS) performance isolation, but incurs higher network traffic.
- **Commodity Storage Components**: WSCs frequently utilize desktop-class drive technology to lower CapEx. Storage software handles global aggregation, data replication, and tail latency mitigation.

### 3. Networking Fabric
Networking infrastructure must provide high inter-node bandwidth without inflating facility costs:

- **Bisection Bandwidth Constraint**: High-port-count cluster switches are disproportionately expensive; scaling bisection bandwidth by $10\times$ can increase interconnect costs by nearly $100\times$.
- **Oversubscribed Topologies**: Standard rack deployment connects commodity ToR switches (e.g., 48 ports) with a limited number of uplinks (e.g., 8 uplinks to cluster-level switches), creating an oversubscribed bisection ratio.
- **Locality Awareness**: Cluster software must remain aware of rack-level network locality to avoid saturating scarce cluster-level uplink bandwidth.

### 4. Building & Facilities Infrastructure
Physical facilities supply electrical power and thermal dissipation required to run tens of megawatts of computing equipment:

- **Power Delivery Hierarchy**: High-voltage utility grid feeds $\longrightarrow$ Datacenter Substation $\longrightarrow$ Power Distribution Units (PDUs) $\longrightarrow$ Bus Ducts $\longrightarrow$ Server Board Voltage Regulators. Uninterruptible Power Supplies (UPS), generators, and battery backups protect against power interruption at every tier.
- **Cooling Infrastructure**: Multi-tier heat exchange loops circulate cold air through rack chassis, extract heat via chilled water exchangers, and dissipate thermal energy outdoors via cooling towers.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Direct-Attached Storage (DAS)** | Local NVMe / Server-Attached Storage |
| **Bisection Bandwidth** | Cross-Fabric Bandwidth / Spine Capacity |

## Related

- [[Datacenter Systems/Warehouse-Scale Computer Architecture|Warehouse-Scale Computer Architecture]] — Hub for this topic
- [[Datacenter Systems/Warehouse-Scale Computer Architecture/The Datacenter as a Computer|The Datacenter as a Computer]] — The WSC abstraction and topology
- [[Datacenter Systems/Warehouse-Scale Computer Architecture/Scatter-Gather Query Trace|Scatter-Gather Query Trace]] — Processing a query across a WSC
