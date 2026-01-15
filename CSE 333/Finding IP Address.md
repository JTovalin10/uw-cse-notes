# three parts for finding IP Address
1. network addresses
2. Data structure for address info
3. DNS finding IP info

# IPv4 Network Addresses
- it is a 4-byte tuple
	- 128.95.4.1 (80:5f:04:01 in hex)
	- There are 2^32 addresses
# IPv6 Network Address
- 16-byte tuple
- group of 4 hex digits

# IPv6 Address Structures
```c
// IPv4 4-byte address_

struct in_addr {

uint32_t s_addr; // Address in network byte order_

};

// An IPv4-specific address structure_

struct sockaddr_in {

sa_family_t sin_family; // Address family: AF_INET_

in_port_t sin_port; // Port in network byte order_

struct in_addr sin_addr; // IPv4 address_
unsigned char sin_zero[8]; // Pad out to 16 bytes_
}
```
