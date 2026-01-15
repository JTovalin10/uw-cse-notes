# What are the types of Internet Protocol Stack
1. **Physical** (Layer 1)
	- Deals with raw bits over a physical medium
	- Examples: copper wire, fiber optic, radio waves
2. **Link** (Layer 2)
	- Moves frames between adjacent nodes
	- Examples: Ethernet, 3G, cable, DSL, 802.11 (WiFi)
	- Handles MAC addresses
3. **Network/Internet** (Layer 3)
	- IP - you need to support IP in order to gain access to everything else
	- Handles routing packets across networks
	- Handles IP addresses
4. **Transport** (Layer 4)
	- TCP (reliable, ordered, connection-oriented)
	- UDP (unreliable, unordered, connectionless)
	- Handles port numbers
5. **Application** (Layer 7)
	- SMTP (email), HTTP (web), RTP (streaming), DNS (name resolution)
	- What users interact with
![[Screenshot 2026-01-09 at 1.16.21 PM.png]]

# Key Concepts
- **End-to-end principle**: complex functions should be implemented at endpoints, not in the network
- **Hourglass model**: many apps on top, many link technologies on bottom, but IP is the narrow waist in the middle

# Advantages
- information hiding and reuse
	- a system can work in any system with this [[Encapsulation]]
- information hiding to connect different systems
	- a router can convert wifi to ethernet and connect different servers
# Disadvantages
- adds overhead
	- more of an impact if the packet is small
	- if client is paying per byte this is included for them
- Hides information
	- App might care about network properties (e.g., latency, bandwidth, etc)
	- Network may need to know about app priorities (e.g., QoS)
		- You don't know what protocol the client is using (wifi or internet)

# How do we achieve this
## Demultiplexing
- Incoming message must be passed to the protocols that it uses
- Done with demultiplexing keys in the headers ![[Screenshot 2026-01-09 at 1.07.42 PM.png]]

# Related
- [[Encapsulation]]
- [[OSI Layers]]
- [[Protocols and Layers]]