# Kernel: Networking Stack and Performance

### Formal Definition
The Linux Kernel Networking Stack is a complex subsystem responsible for moving data between the hardware (NIC) and the user-space applications.

---

## 1. The Receive Path (Low-Level)
1. **Interrupt (Hard IRQ)**: The NIC signals the CPU that a packet is in DMA memory.
2. **NAPI (New API) Polling**: The kernel disables interrupts and enters a polling loop. This prevents "Interrupt Storms" during high load.
3. **softirq**: The "bottom half" of the interrupt handler processes the packets in the `poll` queue.
4. **sk_buff (Socket Buffer)**: The core data structure. It wraps packet data and provides pointers to headers (`skb->transport_header`, `skb->network_header`). It avoids copying by adjusting pointers as it moves up the stack.

## 2. Scaling Technologies
- **RSS (Receive Side Scaling)**: Hardware-based. The NIC hashes headers to distribute packets into multiple RX queues, each pinned to a CPU core.
- **RPS (Receive Packet Steering)**: Software-based. Moves packet processing to a different CPU after the initial interrupt.
- **XPS (Transmit Packet Steering)**: Ensures that a CPU transmitting data uses a specific NIC queue to minimize lock contention.

## 3. Offloading and Batching
- **GRO (Generic Receive Offload)**: The kernel merges multiple incoming TCP segments into one large "virtual" packet before passing it up the stack.
- **TSO (TCP Segmentation Offload)**: The hardware NIC takes a large chunk of data and breaks it into MTU-sized TCP segments, saving CPU cycles.
- **GSO (Generic Segmentation Offload)**: Software-based batching for packets that will eventually be segmented.

## 4. Zero-Copy Networking
- **mmap()**: Mapping kernel buffers directly into user space.
- **sendfile()**: Moving data from a file descriptor to a socket descriptor entirely within kernel space, avoiding context switches.

### Related
- [[Direct Memory Access (DMA)]]
- [[Advanced Linux Networking]]
