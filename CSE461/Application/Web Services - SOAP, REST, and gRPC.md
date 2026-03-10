# Web Services: SOAP, REST, and gRPC

Modern web architectures rely on machine-to-machine communication protocols to build scalable **[[Micro-services]]**.

---

## [[SOAP]]: Simple Object Access Protocol
*   **Paradigm**: **Operation-Oriented** (RPC-style).
*   **Format**: Strictly **[[XML]]** based.
*   **[[WSDL]]**: A schema that defines available operations and message formats.
*   **Use Case**: Enterprise systems requiring high reliability and security standards (WS-*).

[Image: SOAP message structure]

---

## [[REST]]: Representational State Transfer
*   **Paradigm**: **Data-Oriented** (Resource-style).
*   **Methodology**: Manipulates resources identified by URIs using standard **[[HTTP (CSE 333)]]** verbs (GET, POST, PUT, DELETE).
*   **Format**: Typically uses **[[JSON]]** or **[[XML]]**.
*   **Key Principle**: **Statelessness**. Every request must contain all information necessary for the server to fulfill it.

---

## Modern Cloud RPC: [[gRPC]]
*   **Paradigm**: High-performance, binary RPC.
*   **Format**: Uses **[[Protobufs]]** (Protocol Buffers) for efficient serialization.
*   **Transport**: Built on **HTTP/2**, enabling bidirectional streaming and multiplexing.
*   **Use Case**: High-scale cloud infrastructure and micro-service communication.

---

## Comparisons

| Feature | SOAP | REST | gRPC |
| :--- | :--- | :--- | :--- |
| **Data Format** | XML | JSON / XML | Protobuf (Binary) |
| **Transport** | Any (usually HTTP) | HTTP/1.1 | HTTP/2 |
| **Coupling** | Tight (WSDL) | Loose | Tight (IDL) |
| **Performance** | Low | Medium | **High** |
