# Infrastructure Applications

**Infrastructure Applications** are **middleware** protocols that provide the control-plane logic required for the Internet to function. These services facilitate **Name Resolution** (translating human-readable strings into bitwise addresses) and **Network Management** (the programmatic monitoring and configuration of distributed hardware state).

## Name Service (DNS)

The **Domain Name System (DNS)** is a distributed, hierarchical database operating primarily over **Port 53** ([[User Datagram Protocol (UDP)]] for queries; [[Transmission Control Protocol (TCP)]] for zone transfers and large responses). It translates **Fully Qualified Domain Names (FQDNs)** into routable identifiers.

### Low-Level Mechanics
*   **Name Space**: The total set of possible identifiers.
    *   **Flat**: Unstructured, single-table mapping (e.g., legacy `HOSTS.TXT` maintained manually by the **Network Information Center (NIC)**).
    *   **Hierarchical**: A tree-structured system allowing decentralized administration.
*   **Bindings**: A mapping between a **Name** and a **Value** (e.g., an IP address).
*   **Resolution Mechanism**: The algorithmic process used to traverse the hierarchy and retrieve a binding.
*   **Name Server**: The server-side process (e.g., BIND, Unbound) that executes the resolution mechanism.

### The Domain Hierarchy & Zones
*   **Root Servers**: 13 logical authorities at the top of the tree (bootstrapped via hardcoded IP addresses).
*   **Top-Level Domains (TLDs)**:
    *   **Generic (gTLD)**: `.com`, `.org`, `.net`, `.edu`.
    *   **Country Code (ccTLD)**: `.uk`, `.ca`, `.de`.
*   **Zones**: The fundamental unit of administrative delegation. A zone is a subtree of the hierarchy managed by a single authority (e.g., **ICANN** manages the root zone).
*   **Redundancy**: Standard practice requires at least two physically distinct **Name Servers** per zone. Conversely, a single physical server can host multiple zones.

[Image: Example of a domain hierarchy visualized as a tree]
[Image: Domain hierarchy partitioned into administrative zones]

### Resource Records (RR)
Data is stored as a 5-tuple: **(Name, TTL, Type, Class, Value)**.
*   **Type (Record Definitions)**:
    *   **A**: Maps a name to an [[IPv4]] address.
    *   **AAAA**: Maps a name to an [[IPv6]] address.
    *   **NS**: Specifies the **Name Server** authoritative for the domain.
    *   **CNAME**: **Canonical Name**; creates an **Alias** for indirection.
    *   **MX**: **Mail Exchange**; identifies the mail server for the domain.
*   **[[Time to Live (TTL)]]**: In DNS, this is a **Cache Expiration Timer** (in seconds). It dictates how long a **Recursive Resolver** can store a record before it must re-query the authoritative source. *Note: This is semantically different from the hop-limit TTL used in [[Internet Protocol (IP)]] headers.*
*   **Class**: Almost always `IN` (Internet).

### The DNS Resolution Process (Expert Steps)
1.  **Stub Resolver**: The client OS sends a query to a **Local DNS Server** (Recursive Resolver). If the user types a **Partial Name** (e.g., `penguins`), the OS appends the local domain suffix (e.g., `cs.princeton.edu`) before querying.
2.  **Recursive Search**: If not in cache, the local server queries a **Root Server**.
3.  **TLD Referral**: The Root returns an **NS Record** for the TLD (e.g., `.com`).
4.  **Authoritative Referral**: The local server queries the TLD server, which returns an **NS Record** for the domain's authoritative server.
5.  **Final Response**: The local server queries the **Authoritative Name Server**, receiving the **A/AAAA Record**.
6.  **Caching**: The local server stores the result for the duration of its **TTL** and returns the address to the client.

*Diagnostic Tooling*: Engineers use the CLI tool **`dig`** (Domain Information Groper) to manually query name servers. Using `dig +trace` forces the tool to perform the full iterative resolution process starting from the root.

[Image: Sequence of 10 steps showing a client, local server, and remote hierarchy resolving a name]

---

## Network Management

Network management is the process of using the network to manage the network, involving the retrieval of internal state and the application of configuration logic.

### SNMP (Simple Network Management Protocol)
A specialized request/reply and notification protocol (Agent: **Port 161**; Traps: **Port 162**) typically running over [[User Datagram Protocol (UDP)]].
*   **Operations**:
    *   **GET**: Request a specific variable from the agent.
    *   **SET**: Modify a variable in the agent's memory.
    *   **GET-NEXT**: Traverse tables by requesting the lexicographical successor of an ID.
    *   **TRAP**: An asynchronous notification sent from an **Agent** to the **Manager** to signal an event (e.g., link down, high CPU).
*   **MIB (Management Information Base)**: A structured database (MIB-II) of variables organized by group:
    *   **System**: Uptime, node name, location.
    *   **Interfaces**: Physical addresses, packet throughput, error rates.
    *   **Address Translation**: [[Address Resolution Protocol (ARP)]] table data.
    *   **IP**: Routing tables, fragmentation/reassembly stats, drop counts.
    *   **TCP**: Connection states, active/passive opens, retransmission counts.
    *   **UDP**: Datagram delivery statistics.
    *   **ICMP / SNMP**: Protocol-specific error reporting and self-management counters.

### Data Representation: ASN.1 and BER
*   **ASN.1 (Abstract Syntax Notation One)**: A syntax for defining globally unique **Object Identifiers (OIDs)** (e.g., `1.3.6.1.2.1.4.3`).
*   **BER (Basic Encoding Rules)**: The serialization format used to encode ASN.1 data types into a bitstream for transport.

### OpenConfig: Modern Automation
A shift from imperative CLI management to **Declarative**, **Zero-Touch Management**.
*   **Declarative Intent**: The operator defines the *target state* of the network; automation tools resolve the per-device configuration.
*   **YANG (Yet Another Next Generation)**: A modeling language used to define the **Schema** (data model) for device state. Unlike SNMP/MIB, YANG supports complex configuration and status monitoring in a single model.
*   **gNMI (gRPC Network Management Interface)**: A management interface built on **gRPC** (**HTTP/2**), replacing SNMP for modern telemetry and configuration. It uses **Protobufs** for high-efficiency binary serialization. *(Note: **NETCONF** is an earlier XML-based alternative configuration protocol, but gNMI is the modern standard).*

[Image: Zero-touch management control loop via gNMI and YANG]
[Image: Operator managing a network via a tool using gNMI and YANG models]

### Identifier Mapping Summary
1.  **Application Layer**: Uses human-readable **Domain Names**.
2.  **DNS**: Translates Name to **IP Address** (placed in the [[Internet Protocol (IP)]] header).
3.  **Routing/Forwarding**: Maps destination IP to **Next-Hop IP**.
4.  **[[Address Resolution Protocol (ARP)]]**: Translates Next-Hop IP to a **Physical Address** (placed in the [[Link Layer]] frame header).
