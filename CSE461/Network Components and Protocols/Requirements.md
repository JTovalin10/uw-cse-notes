# Stakeholders
1. **Application programmer** — every program uses the network differently
2. **Network operator** — needs the system to be easy to administer and manage
3. **Network designer** — needs the network to be cost-effective

# Scalable Connectivity
**A network must provide connectivity among a set of computers.** The set may differ depending on the goal:
- **Privacy/security** — limits the set of connected machines
- **Growth** — goal is to scale and allow as many users as possible

## Connectivity Basics
At the lowest level, computers connect directly by a physical medium — a [[Link]]. The connected computers are called **nodes**.

- **Point-to-point** — a link limited to a pair of nodes
![[Pasted image 20260123012605.png]]
- **Multi-access** — more than two nodes share a single link
![[Pasted image 20260123012647.png]]
	- Also called the **last mile** — connecting end users to the rest of the network
	- **Wireless** networks (cell, Wi-Fi) are a subclass of multi-access

These links are limited in geographic distance and number of nodes.

## Scaling Beyond Direct Links
Connecting every node directly doesn't scale. Two solutions:
1. **Switched network** — nodes attached to [[Switch]]es via point-to-point links
	- **Circuit switched** — establishes a dedicated circuit from source to destination for a stream of bits
	- **Packet switched** — uses [[Store-and-Forward Packet Switching]] each node receives a complete packet, stores it, then forwards it to the next node. More effective than circuit switching.
	- ![[Pasted image 20260123013134.png]]
2. **Internetwork (internet)** — connects multiple networks using routers/gateways
	- A **router/gateway** is a node connected to two or more networks, forwarding messages between them
	- Each node is identified by an **address** — a byte string that uniquely identifies it

# Cost-Effective Resource Sharing
Networks use [[Multiplexing]] to share resources among multiple users, similar to timesharing a computer.

![[Pasted image 20260123014203.png]]
![[Pasted image 20260123014707.png]]

Three main multiplexing approaches:
- **[[Synchronous Time-Division Multiplexing]]** — divides time into equal quanta, each flow gets a round-robin turn
- **[[Frequency-Division Multiplexing]]** — each flow transmits at a different frequency
- **[[Statistical Multiplexing]]** — like STDM but data is transmitted on demand rather than in predetermined slots, so idle flows don't waste capacity

# Support for Common Services
A network provides logical channels over which application processes communicate. Designing these channels means understanding common communication needs and building that functionality into the network.

![[Pasted image 20260123015114.png]]

## Reliable Message Delivery
Three general classes of failure:
1. **Bit errors** — from electrical interference, lightning, power surges, microwave ovens
2. **Packet loss** — packets dropped in transit
3. **Link/node failure** — physical link is cut or a connected computer crashes

# Manageability
Managing a network includes upgrading equipment as it grows, troubleshooting problems, and adding new features for new applications.
