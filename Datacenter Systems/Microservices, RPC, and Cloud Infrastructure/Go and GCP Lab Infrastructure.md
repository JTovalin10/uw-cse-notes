# Microservices: Go and GCP Lab Infrastructure

## Systems Programming in Go (Golang)

Labs in this course are implemented in Go, engineered specifically for scalable network services:

- **Goroutines (Lightweight Concurrency)**:
  - Go runtimes employ an $M:N$ user-space scheduler multiplexing $M$ goroutines across $N$ OS kernel threads.
  - Goroutines begin with a compact dynamic stack of just **2 KB** (compared to 2 MB–8 MB fixed stacks for standard POSIX `pthreads`), allowing a single machine to host hundreds of thousands of concurrent connections.
- **Integrated Netpoller**:
  - The Go runtime integrates network I/O with Linux `epoll`. When a goroutine blocks on a network read or write, the runtime parks the goroutine without blocking the underlying OS thread, executing other runnable goroutines until the network socket triggers an `epoll` wakeup.
- **CSP Channels**:
  - Provides thread-safe message passing (`chan T`) to communicate between concurrent routines without low-level mutex contention.

---

## Google Cloud Platform (GCP) Lab Infrastructure

Course assignments execute on Google Cloud Platform:
- Each student group is provisioned dedicated **GCP Compute Engine Virtual Machines**.
- Microservices are compiled into Docker containers, networked over virtual subnets, and deployed within these VM instances.
- **Operational Constraint**: Cloud resources operate under strict educational budget credits. **Virtual machines must be stopped when not actively executing experiments** to avoid exhausting credits prematurely on idle compute time.

## Industry Standard Terms

| Course Term | Industry / Production Term |
| :--- | :--- |
| **Netpoller** | I/O Multiplexer / Event Demultiplexer (`epoll` wrapper) |
| **GCP VM** | Compute Engine Virtual Machine / Cloud Instance |

## Related

- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure|Microservices]] — Hub for this topic
- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Docker and Kubernetes|Docker and Kubernetes]] — Containers and orchestration
- [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/gRPC Call Trace|gRPC Call Trace]] — A full gRPC call from client to server
