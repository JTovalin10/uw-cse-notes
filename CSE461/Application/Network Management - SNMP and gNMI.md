# Network Management: SNMP and gNMI

Network management involves the programmatic monitoring and configuration of distributed hardware state. It is a core **[[Infrastructure Applications|Infrastructure Application]]**.

---

## SNMP: Simple Network Management Protocol

The legacy standard for network monitoring, operating over **UDP Ports 161 (Agent)** and **162 (Traps)**.

### Operations
*   **GET**: Retrieve a specific variable.
*   **SET**: Modify a variable (e.g., disable an interface).
*   **TRAP**: An asynchronous notification from an agent to the manager (e.g., "Link Down").

### MIB: Management Information Base
*   A structured database of variables (e.g., `ipInReceives`, `ifSpeed`).
*   **OIDs (Object Identifiers)**: Globally unique IDs in dot notation (e.g., `1.3.6.1...`).
*   **ASN.1 / BER**: The syntax and encoding rules used to serialize management data.

---

## Modern Management: gNMI and Streaming Telemetry

Industry has shifted from "pull-based" SNMP to "push-based" **Streaming Telemetry**.

### [[gNMI]]: gRPC Network Management Interface
*   **Transport**: Built on **gRPC** (**HTTP/2**).
*   **Efficiency**: Uses **[[Protobufs]]** for compact binary serialization.
*   **Capability**: Supports both monitoring and **Declarative Configuration**.

### [[YANG]]: Yet Another Next Generation
*   A modeling language used to define the **Schema** for device state.
*   Enables **Zero-Touch Management** where operators declare intent, and tools resolve per-device configuration.

![[Pasted image 20260214020718.png]]
*Figure: Zero-touch management control loop via gNMI and YANG*

---

## Comparisons

| Feature | SNMP | gNMI |
| :--- | :--- | :--- |
| **Paradigm** | Pull (Polling) | Push (Streaming) |
| **Encoding** | BER (TLV) | Protobuf (Binary) |
| **Config** | Imperative / Limited | Declarative / Comprehensive |
| **State** | MIB | YANG Model |
