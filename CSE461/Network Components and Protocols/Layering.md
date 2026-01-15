# What are the types of Internet Protocol Stack
1. link
	1. ethernet, 3g, cable, DSL, 802.11
2. Internet
	1. Ip
		1. you need to support Ip n order to gain access to everything else
3. transport
	1. TCP and UDP
4. Application
	1. SMTP, HTTP, RTP, DNS
	![[Screenshot 2026-01-09 at 1.16.21 PM.png]]

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
		- You dont know what protocol the client is using (wifi or internet)

# How do we achieve this
## Demultiplexing
- Incoming message must be passed to the protocols that it uses
- Done with demultiplexing keys in the headers ![[Screenshot 2026-01-09 at 1.07.42 PM.png]]