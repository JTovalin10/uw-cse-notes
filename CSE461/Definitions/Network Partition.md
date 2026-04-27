# Network Partition

A **Network Partition** (often referred to as a "netsplit") is a failure state in a network where communication between two or more sets of nodes is interrupted, creating isolated "islands" or components. While nodes within a component can communicate, they cannot reach nodes in other components.

## Why it Happens

From a systems engineering perspective, partitions are rarely "clean" and often result from a combination of the following:

### 1. Physical and Link Layer Failures
- **Fiber Cuts:** The most common cause in wide-area networks (WANs).
- **Hardware Faults:** Failed line cards in routers or port failures on top-of-rack (ToR) switches.
- **Power Outages:** Loss of power to a specific data center rack or availability zone.

### 2. Control Plane Misconfigurations
- **BGP Route Flapping/Leaks:** Incorrect routing advertisements can cause traffic to be "blackholed" or routed into a loop, effectively isolating a subnet.
- **VLAN/STP Issues:** Spanning Tree Protocol (STP) loops or VLAN tagging mismatches can block ports that should be forwarding.

### 3. Congestion and Bufferbloat
- **Severe Congestion:** When a link is saturated, packet loss and latency (jitter) can increase to the point where heartbeat signals (Keep-alives) between nodes are lost. 
- **The "False Positive":** From the perspective of a distributed protocol, a extremely slow link is indistinguishable from a dead link, leading to a "logical" partition even if physical connectivity exists.

### 4. Software and Security Policy Failures
- **Firewall Rules:** An erroneous `iptables` update or a misconfigured ACL can suddenly block inter-node traffic (e.g., blocking port 2379 for etcd).
- **MTU Mismatches:** If path MTU discovery fails and a node sends packets larger than an intermediate link can handle without fragmentation (and the DF bit is set), those packets will be dropped, causing a partial partition.

## When it Occurs

Partitions are a "when," not an "if," in large-scale systems. They occur during:
- **Scheduled Maintenance:** Failovers that don't go as planned.
- **Unforeseen Hardware Failure:** Random component degradation.
- **Network Upgrades:** Introducing new routing logic or topology changes.
