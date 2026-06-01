# Link Layer: Software Defined Networking (SDN)

## Low-Level Primer: The Centralization of Control
Historically, network switches and routers were **Distributed Systems**. Each device ran its own instance of complex algorithms (e.g., Spanning Tree, OSPF) and made independent forwarding decisions based on its local view of the topology. **Software Defined Networking (SDN)** breaks this model by decoupling the high-level decision-making logic from the physical packet-forwarding hardware.

---

## 1. Control Plane vs. Data Plane

SDN strictly divides the network into two functional layers:

### The Control Plane (The "Brains")
*   **Location**: Resides in a centralized **SDN Controller** (e.g., ONOS, OpenDaylight).
*   **Role**: Maintains a global view of the network topology. It runs the complex routing and policy algorithms and pushes forwarding rules down to the switches.
*   **Abstraction**: Acts like the "Operating System" of the network.

### The Data Plane (The "Brawn")
*   **Location**: Resides in the physical **SDN Switches**.
*   **Role**: Performs ultra-fast packet forwarding based on a **Flow Table** provided by the controller.
*   **Hardware**: Switches become "dumb" but extremely efficient, as they no longer need to run complex distributed protocols.

---

## 2. OpenFlow (The Southbound API)

OpenFlow is the industry-standard protocol used by the controller to manage the switches.

### Flow Table Mechanics
Each entry in a switch's flow table consists of:
1.  **Match Fields**: Identifying packets based on any header (MAC, IP, TCP Port).
2.  **Actions**: What to do with matching packets (e.g., "Forward to Port 3," "Drop," "Rewrite VLAN tag").
3.  **Counters**: Statistics for monitoring traffic.

### Programmability
*   **Reactive**: The switch sends the first packet of a new flow to the controller; the controller decides the path and installs a rule.
*   **Proactive**: The controller pre-populates the flow tables based on anticipated traffic patterns.

---

## 3. Advantages of SDN

*   **Global Visibility**: Because the controller sees the entire network, it can calculate more optimal paths than distributed protocols.
*   **Rapid Innovation**: Network behavior can be changed by updating software on the controller, rather than upgrading hardware on 1,000 switches.
*   **Policy Enforcement**: Global policies (e.g., "All guest traffic must pass through a firewall") are easily implemented and verified.

---

## 4. The Challenges of SDN

*   **Scalability**: A single controller can become a bottleneck or a single point of failure (solved via distributed controller clusters).
*   **The Bootstrap Problem**: How does the controller communicate with a switch if the switch doesn't have forwarding rules yet? This "Chicken and Egg" problem requires a dedicated management network or basic pre-installed rules.

[Image: SDN Architecture showing Northbound API, Centralized Controller, Southbound API (OpenFlow), and the Data Plane switches]
