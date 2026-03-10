# Domain Name System (DNS)

The **Domain Name System (DNS)** is a distributed, hierarchical database that translates human-readable **Domain Names** into routable **IP Addresses**. It is a fundamental **[[Infrastructure Applications|Infrastructure Application]]**.

---

## Low-Level Mechanics
*   **Port**: Operates primarily over **UDP Port 53**.
*   **Bindings**: Mappings between a **Name** and a **Value** (e.g., an A record).
*   **Name Space**:
    *   **Flat**: Simple, unstructured list (e.g., `HOSTS.TXT`).
    *   **Hierarchical**: Tree-structured system (e.g., `.com`, `.org`).

---

## The DNS Hierarchy

### 1. Root Servers
*   13 logical authorities at the top of the tree.
*   Utilize **[[BGP Any-cast]]** to route requests to the nearest physical instance.

### 2. Top-Level Domains (TLDs)
*   **gTLDs**: Generic domains like `.com`, `.edu`.
*   **ccTLDs**: Country-specific domains like `.uk`, `.ca`.

### 3. Authoritative Name Servers
*   Hold the actual **Resource Records** for a specific zone.

![[Pasted image 20260214012918.png]]
*Figure: Example of a domain hierarchy visualized as a tree*

---

## Resource Records (RR)
Data is stored as 5-tuples: **(Name, TTL, Type, Class, Value)**.
*   **A**: IPv4 address.
*   **AAAA**: IPv6 address.
*   **NS**: Authoritative Name Server for the domain.
*   **CNAME**: Alias for another name.
*   **MX**: Mail Exchange server.
*   **[[Time to Live (TTL)]]**: Cache duration for the record.

---

## The Resolution Process

1.  **Stub Resolver**: Client OS sends a **Recursive Query** to a **Local DNS Server**.
2.  **Iterative Resolution**: The local server queries the Root, TLD, and Authoritative servers in sequence.
3.  **Caching**: The results are stored locally for the duration of the **TTL**.

![[Pasted image 20260214014920.png]]
*Figure: Sequence of 10 steps showing the iterative resolution process*

---

## Diagnostic Tools
*   **`dig`**: Domain Information Groper. Use `dig +trace` to see the full iterative process.
