# CSE461: Parallel Connections

**Parallel connections** are one simple way to reduce [[Page Load Time (PLT)]]:
- The browser runs multiple HTTP instances in parallel to the same server
- The server is unchanged — it already handles concurrent requests from many clients

## Why It Helps

A single HTTP connection often did not fully utilize the available network capacity (especially for small objects that don't stress bandwidth). Parallel connections:
- Pull in the completion time of the last fetch
- Reduce the impact of individual connection latency

## Drawbacks

- Parallel connections compete with each other for network resources
	- One client opening 8 parallel connections behaves like 8 separate sequential clients
	- This exacerbates network bursts and packet loss
- Replaced by [[Persistent Connections]] and eventually HTTP/2 multiplexing as better solutions

## Related
- [[Persistent Connections]] — the cleaner alternative to parallel connections
- [[Page Load Time (PLT)]] — the metric parallel connections aim to reduce
- [[HTTP - Protocol Mechanics and Evolution]] — HTTP/1.1 persistence and HTTP/2 multiplexing
