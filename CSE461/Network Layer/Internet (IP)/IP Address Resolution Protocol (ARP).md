## Address Resolution Protocol (ARP)
We need to translate IP addresses to link-level addresses that make sense on a network. There are two approaches:
1. **Encode the host's physical address in the host part of its IP address**
	1. limited because the address cannot be longer than a certain number of bits depending on the address class
2. **Each host maintains a table of address pairs** which maps IP addresses to physical addresses
	1. each host dynamically learns the content of the table using the network
	2. this is **ARP (Address Resolution Protocol)**
		1. enables each host on a network to build up a table of mappings between IP addresses and link-level addresses

### How ARP Works
- ARP maintains a **cache** (table) for fast lookup
- The host first checks the cache
- If the address is not found:
	1. The host broadcasts an **ARP query** onto the network containing the target's IP address
	2. Each host on the network receives the query and checks if it matches its own IP address
	3. If a host matches, it sends a response containing its link-layer address back to the originator
	4. The originator adds this mapping to its ARP table
- Since each query contains the sender's IP and link-layer address, all hosts on the network can learn the sender's addresses and cache them
- If an entry already exists, the host refreshes it by resetting the expiration timer

![[Pasted image 20260215024442.png]]

### ARP Packet Fields
- **HardwareType** - specifies the type of physical network (e.g., Ethernet)
- **ProtocolType** - specifies the higher-layer protocol (e.g., IP)
- **HLen** ("hardware address length") and **PLen** ("protocol address length") - specify the length of the link-layer address and higher-layer protocol address, respectively
- **Operation** - specifies whether this is a request or a response
- The source and target hardware (Ethernet) and protocol (IP) addresses

See also: [[IP Global Addresses]], [[Dynamic Host Configuration Protocol (DHCP)]]
