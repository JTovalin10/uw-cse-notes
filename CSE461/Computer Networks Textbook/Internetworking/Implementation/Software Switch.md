## Software Switch
A general-purpose processor with four [[Network Interface Card (NIC)|NICs]].

**Packet path** (e.g., arriving on NIC 1, forwarded out NIC 2):
1. NIC 1 receives the packet and copies its bytes directly into main memory over the I/O bus ([[Peripheral Component Interconnect Express (PCIe)|PCIe]]) using [[Direct Memory Access (DMA)]]
2. The CPU examines the packet header to determine which interface the packet should be sent out on
3. The CPU instructs NIC 2 to transmit the packet, again directly out of main memory using DMA

The packet is buffered in main memory (the "store" half of store-and-forward). The CPU only reads the necessary header fields into its internal registers for processing.

![[Pasted image 20260215210232.png]]

**Bottleneck**: all packets must pass into and out of main memory
- throughput = pps x BitsPerPacket
- pps = packets per second

See also: [[Hardware Switch]], [[Software Defined Networks]]
