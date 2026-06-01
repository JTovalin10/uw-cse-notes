# Linux: Advanced Networking (eBPF, XDP, DPDK)

## 1. eBPF (Extended Berkeley Packet Filter)
eBPF allows running sandboxed programs inside the Linux kernel without changing kernel source code or loading modules.
- **Usage**: Monitoring, security (Seccomp), and high-performance networking.
- **Verifer**: Ensures eBPF code is safe (no infinite loops, no illegal memory access).

## 2. XDP (eXpress Data Path)
XDP is a high-performance data path for eBPF programs.
- **Mechanism**: Runs eBPF programs at the earliest possible point in the driver (before `sk_buff` allocation).
- **Actions**:
  - `XDP_DROP`: Discard packet (DDoS mitigation).
  - `XDP_TX`: Send packet back out the same interface (Load Balancing).
  - `XDP_PASS`: Pass to the regular kernel stack.
- **Performance**: Can handle millions of packets per second on a single CPU core.

## 3. Kernel Bypass
For extreme performance, some applications bypass the Linux kernel entirely.
- **DPDK (Data Plane Development Kit)**: A set of libraries that move packet processing entirely to user space. Uses "Poll Mode Drivers" to eliminate interrupt overhead.
- **RDMA (Remote Direct Memory Access)**: Allows one computer to access memory on another computer without involving either one's OS. Zero-copy and ultra-low latency.

## 4. Virtualization and Containers
- **veth pairs**: Virtual Ethernet cables used to connect namespaces (containers) to the host.
- **Linux Bridge**: A software switch used to connect `veth` pairs together.
- **Namespaces (netns)**: Provides isolation of the networking stack (interfaces, routing tables, iptables).
- **SR-IOV (Single Root I/O Virtualization)**: Allows a single physical NIC to appear as multiple virtual NICs (VFs) to different VMs, providing near-native performance.

### Related
- [[Kernel Networking Stack]]
- [[Networking Debugging]]
