# Link Layer Overview

Transfers messages (frames) over one or more connected links. Builds on the physical layer. Runs on NIC + OS (delay-sensitive parts in hardware).

## Subdirectories

| Directory | Contents |
|-----------|----------|
| **Framing** | [[Framing]], byte stuffing, bit stuffing |
| **Error Detection and Correction** | [[Checksum]], [[Cyclic Redundancy Check (CRC)]], parity, Hamming |
| **Multiple Access** | Ethernet, WiFi, ALOHA, CSMA, TDM, FDM |
| **Retransmission** | Stop-and-wait, sliding window, ARQ |
| **Switching** | [[Network Switch (Switching)]], learning bridges, spanning tree, VLANs |
| **Wireless** | WiFi, Bluetooth, spread spectrum |
| **Access Networks** | Cellular, 5G, PON |

## Key concepts

- [[Store and forward packet switching]] — How packets move through switches
- [[Layer Addresses (L(n))]] — L2, L3 addresses
- [[Frame]] — Unit of data at link layer
- [[Media Access Control (MAC)]] — Who gets to transmit
- [[Backwards Learning]] — How switches learn addresses
