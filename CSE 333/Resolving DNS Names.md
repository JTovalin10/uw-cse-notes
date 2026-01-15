The POSIX way to get this: **getaddressinfo**()
- found in
```c
#include <netdb.h>
int getaddrinfo(const char* hostname, const char* service, const struct addrinfo* hints, struct addrinfo** res);
```
- you tell it what hostname and service you want resolved
- set up "hints" structure with constraints you want to be respected
- returns a list of results in the addrinfo struct (res)
	- returns 0 on success
	- returns a negative number on failure
	- you free the structure later using **freeaddrinfo**()
```c
struct addrinfo {

int ai_flags; // additional flags_

int ai_family; // AF_INET, AF_INET6, AF_UNSPEC_

int ai_socktype; // SOCK_STREAM, SOCK_DGRAM, 0_

int ai_protocol; // IPPROTO_TCP, IPPROTO_UDP, 0_

size_t ai_addrlen; // length of socket addr in bytes_

struct sockaddr* ai_addr; // pointer to socket addr_

char* ai_canonname; // canonical name_

struct addrinfo* ai_next; // can form a linked list_

};
```
