# CSE461: Persistent Connections

**Persistent connections** are an alternative to [[Parallel Connections]] for reducing [[Page Load Time (PLT)]]:
- Make a single TCP connection to a server and reuse it for multiple HTTP requests
- Avoids the overhead of re-establishing a new connection (and re-triggering TCP slow start) for each object

## Why It Helps

[[Parallel Connections]] compete with each other for network resources — one client with 8 parallel connections behaves like 8 separate clients, exacerbating bursts and loss. Persistent connections:
- Maintain a single, well-behaved TCP connection
- Allow the TCP congestion window to grow and stabilize over the lifetime of the connection

![[Screenshots/Persistent Connections.png]]

## Related
- [[Parallel Connections]] — the alternative strategy (less efficient)
- [[Page Load Time (PLT)]] — the metric persistent connections aim to reduce
- [[HTTP - Protocol Mechanics and Evolution]] — HTTP/1.1 `Connection: keep-alive` and HTTP/2 multiplexing
