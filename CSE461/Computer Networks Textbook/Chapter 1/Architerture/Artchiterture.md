# Layering and Protocols
### Layering
abstraction naturally leads to layering. With layering we are able to:
1. decompose the problem of building a network into more manageable components
2. provides a more modular design
	1. if you want to add a new service you may need to only modify the func at one layer
Non abstracted later
![[Pasted image 20260123021528.png]]
Abstracted layer
![[Pasted image 20260123021543.png]]

## Protocols
the abstracted object that make up the layers of a network system are called protcos

they provide a communication service that higher level obkjects use to exchange messages

Each protocol defines two different interfaces
1. service interface
	1. defines the operation that local objects can perform on the protocol
2. perr interface
	1. defines t he form and meaning of messages exchanged bwteen protocol peers to implement the communication service
![[Pasted image 20260123021812.png]]
# Encapsulation
Encapsulation is used by adding things that the client doesnt care about but is used in the network
![[Pasted image 20260123021953.png]]

# OSI Model
Open systems intercourse.
![[Pasted image 20260123022103.png]]
Starting at the bottom and working up, the _physical_ layer handles the transmission of raw bits over a communications link. The _data link_ layer then collects a stream of bits into a larger aggregate called a _frame_. Network adaptors, along with device drivers running in the node’s operating system, typically implement the data link level. This means that frames, not raw bits, are actually delivered to hosts. The _network_ layer handles routing among nodes within a packet-switched network. At this layer, the unit of data exchanged among nodes is typically called a _packet_ rather than a frame, although they are fundamentally the same thing. The lower three layers are implemented on all network nodes, including switches within the network and hosts connected to the exterior of the network. The _transport_ layer then implements what we have up to this point been calling a _process-to-process channel_. Here, the unit of data exchanged is commonly called a _message_ rather than a packet or a frame. The transport layer and higher layers typically run only on the end hosts and not on the intermediate switches or routers.
# Internet Architecture
The main two protocols are **TCP/IP** in which the Internet Architecture is sometimes called after its main protocols

![[Pasted image 20260123022234.png]]

1. net$_n$ 
	1. at the lowest level and is a wide variety of network protcols which are implemented by a cpmbination of hardwarae and software
2. IP
	1. central part of the internet architecture
	2. supports the interconnection of multiple networking technolgoies into a single logical internetwork
3. **Above IP the two main protcols**
	1. TCP
		1. provides a reliable byte-steam channel
	2. UDP
		1. provides an unreliable datagram delivery channel
		2. faster than TCP
	3. both are end to end protocls or transport protocols
4. transport lauyer
	1. HTTP
	2. FTP
	3. DNS
	   TFTP