# Stakeholders
The three main stakeholders are:
1. application programmer
	1. every program needs the network in different ways
2. network operator
	1. needs the system to be easy to administer and manage
3. network designer
	1. needs network to be cost-effective
# Scalable Connectivity
**A network must provide connectivity among a set of computers**. However, depending on your goal the set of computers may differ
- privacy and security
	- typically limits the set of machines that are connected
- growth
	- goal is to scale and allow as many users to connect
## Connectivity
At the lowest level, two or more computers are directly connected by some physical medium--[[Link]] (computers are called nodes)
### Point to Point
when physical links are sometimes limited to a pair of nodes
![[Pasted image 20260123012605.png]]
### Multi access
when more than two nodes may share a single physical link

It is important to note that these links are limited in size, in terms of both geographical distance they can cover and the number of nodes that they can connect. 

Another name for this is the *last mile*, connecting end users to the rest of the network
![[Pasted image 20260123012647.png]]
#### Wireless
These are a subclass of multi access that are provided by cell networks and Wi-Fi networks,

## Problem and solution
If every node was connected directly by a link then the network would be very limited in the clients they can support. 

The solution to this is:
1. switched network: a set of nodes, each of which is attached to one or more point-to-point links
	1. circuit switched
		1. established a dedicated circuit across a sequence of links and then allows the source node to send a stream of bits across this circuit to a destination node
	2. packet switched
		1. more effective than circuit
		2. uses the store-and-forward strategy. Where each node first receives a complete packet overt some link, stores it in internal memory, and then forwards the packet to the next node
	3. ![[Pasted image 20260123013134.png]]
2. internetwork (internet)
	1. router/gateway
		1. a node that is connected to two or more networks
		2. forwards messages from one network to anther
	2. each node must be able to say which of the other nodes on the network it wants to communicate with
		1. done with assigning an address to each node
			1. byte string that identifies a node
# Cost-Effective Resource Sharing
## Multiplexing
a system resource is shared among multiple users, similar to timesharing a computer system
![[Pasted image 20260123014203.png]]

![[Pasted image 20260123014707.png]]
### Synchronous Time-Division Multiplexing (STDM)
The idea behind this is to divide time into equal-sized quanta, and in a round robin fashion, give each flow a chance to send its data over the physical link
### Frequency-Division Multiplexing (FDM)
the idea behind this is to transmit each flow over the physical layer at a different frequency

### Statistical Multiplexing
addresses the short comings of FDM and STDM
1. like STDM it shared the physical link over time
2. unlike STDM data is transmitted from each flow on demand rather than during a predetermined time slot
3. This then makes it so that if only one flow has data to send, it gets to transmit that data without waiting for another

# Support for common Services
#define network: Think of a network as providing the means for a set of application processes that are distrbuted over those computers to communicate or the next requirement of a computer network is that the application prorgams running on the hosts connectd to the network must be able to communicate in a meaningful way
![[Pasted image 20260123015114.png]]

Intutievly networks can be seen as providing logical channels over which application-level processes can communicaet with each other. 
## Common Communication Patterns
Designing abstract channels involve first understanding the communication needs of a represenatative collection of applications, extracting their common communication requiremetns, and then incoproating the functionality that meets these requirements in the network

## reliable message delivery
Three general classes of failure
1. packets transmitted over a physical link may encouter bit errors
	1. lightning strikes
	2. power surges
	3. microwave ovens
2. packet loss
3. physical link is cut or the computer it is connecected tocrashed

# Manageability
managing a network includes upgrading requipment as the network grows to carry more traffic or ereaches more users, troubleshooting the network when things go wrong or performance isnt as desired, and adding new features in support of new applications