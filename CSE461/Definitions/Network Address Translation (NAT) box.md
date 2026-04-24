# Network Address Translation (NAT) box

A **Network Address Translation (NAT) box** (or NAT router) is a device that maps multiple private (internal) IP addresses to a single public (external) IP address.

## Overview
NAT is a mechanism used to conserve IPv4 addresses by allowing an entire private network to share a single public IP address for internet access.

## How it Works
1.  **Translation Table**: The NAT box maintains a table of active connections.
2.  **Outgoing Packets**: When a device on the private network sends a packet to the internet, the NAT box replaces the device's private source IP and port with its own public IP and a unique source port.
3.  **Incoming Packets**: When a response arrives at the public IP and the assigned port, the NAT box looks up the port in its table and forwards the packet to the original internal device.

## Motivation
- **IPv4 Address Exhaustion**: NAT significantly slowed down the depletion of the IPv4 address space by allowing many devices to share one public IP.
- **Security**: It provides a layer of security by hiding the internal network structure from the outside world.

## Drawbacks and Controversy
- **Violates End-to-End Principle**: Routers are traditionally supposed to be "stateless" and only forward packets. NAT requires routers to maintain per-flow state and modify packet headers (IP and TCP/UDP ports).
- **Incompatibility with some protocols**: Some applications (like P2P, SIP, or FTP) embed IP addresses in their payloads, which NAT may break without specific "Application Level Gateways" (ALGs).
- **NAT Traversal**: Making internal services accessible from the outside requires manual port forwarding or complex protocols like STUN, TURN, or ICE.

## IPv6 and NAT
One of the goals of [[IPv6]] is to eliminate the need for NAT by providing a large enough address space so that every device can have its own public IP address, thus restoring the end-to-end transparency of the internet.

![[../Screenshots/internel, external translation table.png]]
![[../Screenshots/NAT.png]]
![[../Screenshots/NAT (5).png]]
